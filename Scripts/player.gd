extends CharacterBody2D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_height = 200
@export var acceleration = 10.0

var target_velocity = Vector2.ZERO
var spawn_point = Vector2.ZERO
var facing_direction = 1
var health = 100
var max_fall_speed = 200

@export var knockback_strength: float = 400.0
@export var knockback_duration: float = 0.2

var is_knocked_back = false
var knockback_timer = 0.0
var knockback_velocity = Vector2.ZERO

func _ready():
	spawn_point = transform

func _physics_process(delta):
	if is_knocked_back:
		# Während Knockback keine Eingaben zulassen
		velocity = knockback_velocity
		apply_gravity(delta)
		move_and_slide()
		
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			is_knocked_back = false
			if velocity.y < 0:
				target_velocity.y = 0
	else:
		var direction = Vector2.ZERO

		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1

		if direction != Vector2.ZERO:
			if direction.x != facing_direction:
				facing_direction = direction.x
				$Sprite.set_flip_h(facing_direction == -1)
			
			if ($Sprite.animation != "run"):
				$Sprite.animation = "run"
			direction = direction.normalized()
		else:
			if ($Sprite.animation != "idle"):
				$Sprite.animation = "idle"
				
		var target_speed = direction.x * speed
		# Ground Velocity
		target_velocity.x = lerp(velocity.x, target_speed, acceleration * delta)

		if not is_on_floor():
			if velocity.y == 0: # kopf stossing
				target_velocity.y = 0

		apply_gravity(delta)

		if Input.is_action_just_pressed("jump") and is_on_floor():
			target_velocity.y = -sqrt(jump_height * 2.0 * fall_acceleration)

		# Moving the Character
		velocity = target_velocity
		move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	respawn()

func take_damage(damage):
	health -= damage

	if health <= 0:
		respawn()
		health = 100
	else:
		$Sprite.material.set_shader_parameter("flash_modifier", 1)
		$IFrames.start()

func respawn():
	transform = spawn_point


func apply_knockback(direction: Vector2) -> void:
	take_damage(10)
	is_knocked_back = true
	knockback_timer = knockback_duration
	knockback_velocity = direction * knockback_strength

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		target_velocity.y += fall_acceleration * delta
		target_velocity.y = clamp(target_velocity.y, -INF, max_fall_speed)
	else:
		target_velocity.y = 0


func _on_i_frames_timeout():
	$Sprite.material.set_shader_parameter("flash_modifier", 0)

extends CharacterBody2D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_height = 200

var target_velocity = Vector2.ZERO
var spawn_point = Vector2.ZERO
var facing_direction = 1
@export var acceleration = 10.0  # wie schnell du auf Zielgeschwindigkeit beschleunigst

func _ready():
	spawn_point = transform
	$Sprite.play("idle")

func _physics_process(delta):
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


	if is_on_floor():
		target_velocity.y = 0
	# Vertical Velocity
	else: # If in the air, fall towards the floor. Literally gravity		
		if velocity.y == 0:
			target_velocity.y = 0

		target_velocity.y = target_velocity.y + (fall_acceleration * delta)


	if Input.is_action_just_pressed("jump") and is_on_floor():
		target_velocity.y = -sqrt(jump_height * 2.0 * fall_acceleration)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	respawn()


func respawn():
	transform = spawn_point

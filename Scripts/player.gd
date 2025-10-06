extends CharacterBody2D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_height = 200
@export var acceleration = 10.0
@export var projectile_speed = 200.0
@export var attack_damage = 100.0
@export var projectile_damage = 50.0
@export var attack_speed = 1.0
@export var HealthBar: TextureProgressBar 

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
var attacking = false
var autoattack = false
var projectile_unlocked = false
var double_jump_unlocked = false
var damage_multi = 1.0
var attack_speed_multi = 1.0
var double_jumped = false

var currentLevel = 1

func _ready():
	currentLevel = SaveState.level
	spawn_point = transform
	# 2x Attackspeed (kelch)
	projectile_unlocked = SaveState.artifact3
	double_jump_unlocked = SaveState.artifact1
	if SaveState.artifact4:
		damage_multi = 2.0
	
	if SaveState.artifact2:
		attack_speed_multi = 2.0
	
	HealthBar.max_value = health
	HealthBar.value = health

func _process(_delta):
	if $Weapon/WeaponAnimation/WeaponSprite/AnimationPlayer.speed_scale != (attack_speed * attack_speed_multi):
		$Weapon/WeaponAnimation/WeaponSprite/AnimationPlayer.speed_scale = attack_speed * attack_speed_multi

func _physics_process(delta):
	if is_on_floor():
		double_jumped = false
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
				$Weapon.set_scale(Vector2(facing_direction, 1))
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
			$PlayerJump.play()
			target_velocity.y = -sqrt(jump_height * 2.0 * fall_acceleration)
		elif double_jump_unlocked and not double_jumped and Input.is_action_just_pressed("jump") and not is_on_floor():
			$PlayerJump.play()
			double_jumped = true
			target_velocity.y = -sqrt(jump_height * 2.0 * fall_acceleration)

		# Moving the Character
		velocity = target_velocity
		
		if not attacking:
			$Weapon.rotation = lerp($Weapon.rotation, round($Weapon.rotation / (2*PI))*(2*PI), 0.2)

		move_and_slide()

func _input(event):
	if event.is_action_pressed("attack"):
		attacking = true
		autoattack = true
		attack()
	elif event.is_action_released("attack"):
		autoattack = false

func attack() -> void:
	$Weapon/WeaponAnimation/WeaponSprite/AnimationPlayer.play("attack")
	$Weapon.look_at(get_global_mouse_position())
	if facing_direction == -1:
		$Weapon.rotate(PI)

func activateWeaponHitbox() -> void:
	$Weapon/WeaponAnimation/Hitbox/CollisionShape2D.set_deferred("disabled", false)

func deactivateWeaponHitbox() -> void:
	$Weapon/WeaponAnimation/Hitbox/CollisionShape2D.set_deferred("disabled", true)

func take_damage(damage):
	health -= damage
	
	HealthBar.value = health
	$PlayerHurt.play()

	if health <= 0:
		SaveState.level = 1
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		$Sprite.material.set_shader_parameter("flash_modifier", 1)
		$IFrames.start()

func apply_knockback(direction: Vector2) -> void:
	if not $IFrames.is_stopped():
		return

	take_damage(20 * (1 + (currentLevel / 2 )))
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

func spawn_projectile() -> void:
	if not projectile_unlocked:
		return
	var projectile = preload("res://Scenes/projectile.tscn").instantiate()
	projectile.global_position = $Weapon/Marker2D.global_position
	projectile.damage = projectile_damage * damage_multi
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - projectile.global_position).normalized()
	projectile.linear_velocity = direction * projectile_speed
	get_parent().add_child(projectile)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		if not autoattack:
			attacking = false
		else:
			attack()

func change_attack_speed(new_attack_speed: float) -> void:
	attack_speed = new_attack_speed

func _on_weapon_hit_enemy(body: Area2D) -> void:
	if body.is_in_group("enemy"):
		body.get_parent().take_damage(attack_damage * damage_multi)

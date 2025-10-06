extends CharacterBody2D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_height = 200
@export var movement_range = 20.0

var target_velocity = Vector2.ZERO
var spawn_point = Vector2.ZERO
var movement_area = Vector2.ZERO
var target_location = Vector2.ZERO

func _ready() -> void:
	spawn_point = transform.get_origin()
	movement_area = Vector2(spawn_point.x, spawn_point.y)
	target_location = movement_area

func _physics_process(delta):
	var direction = Vector2.ZERO

	if abs(transform.get_origin().x - target_location.x) < 0.5:
		switch_direction()

	if ((target_location.x - transform.get_origin().x) > 0):
		direction.x = 1
	else:
		direction.x = -1
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	# Ground Velocity
	target_velocity.x = direction.x * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y + (fall_acceleration * delta)

	#if Input.is_action_just_pressed("jump") and is_on_floor():
	#	target_velocity.y = -sqrt(jump_height * 2.0 * fall_acceleration)

	# Moving the Character
	#velocity = target_velocity
	move_and_slide()

func switch_direction():
	if target_location == movement_area:
		target_location = spawn_point
		$Sprite.set_flip_h(false)
	else:
		target_location = movement_area
		$Sprite.set_flip_h(true)

extends CharacterBody2D

@export var speed = 20
@export var target: Node2D
@onready var nav := $NavigationAgent2D as NavigationAgent2D


func _physics_process(delta: float) -> void:
	var direction = to_local(nav.get_next_path_position()).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func make_Path() -> void:
	nav.target_position = target.global_position
	

func _on_timer_timeout() -> void:
	make_Path()

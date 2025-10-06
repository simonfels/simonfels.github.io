extends CharacterBody2D

@export var speed = 1700.0
@onready var nav := $NavigationAgent2D as NavigationAgent2D
var maxHealth = 100
var health = 100
var target: Node2D
var isAlive = true

func _ready():
	var currentLevel = SaveState.level
	maxHealth = maxHealth * (currentLevel / 4)
	health = health * (currentLevel / 4)
	target = get_tree().current_scene.find_child("Player")
	print_debug(target)

func _physics_process(delta: float) -> void:
	if not isAlive:
		$Timer.stop()
		return

	var direction = to_local(nav.get_next_path_position()).normalized()
	velocity = direction * speed * delta
	move_and_slide()

func make_Path() -> void:
	nav.target_position = target.global_position
	

func _on_timer_timeout() -> void:
	make_Path()

func take_damage(damage) -> void:
	health -= damage

	$Sprite.material.set_shader_parameter("flash_modifier", 1)
	
	if health <= 0:
		$AnimationPlayer.play("die")
		$CollisionShape2D.set_deferred("disabled", true)
		$Hitbox/CollisionShape2D.set_deferred("disabled", true)
		isAlive = false
	else:
		$HitFlash.start()

func die() -> void:
	queue_free()


func _on_hit_flash_timeout():
	$Sprite.material.set_shader_parameter("flash_modifier", 0)

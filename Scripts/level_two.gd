extends Node2D

@export var SoulSpawnpoints: Array[Marker2D] = []
var activeMarker: Marker2D

signal levelCompleted
signal soulCaptureProgressTick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TileMapLayer.modulate = Color.GRAY
	var rand = randi_range(1,SoulSpawnpoints.size()) - 1
	activeMarker = SoulSpawnpoints[rand]
	$Seelenbecken.position = activeMarker.position

func _on_seelenbecken_timer_tick() -> void:
	soulCaptureProgressTick.emit()
	
	var enemy = preload("res://Scenes/enemyType2.tscn").instantiate()
	var mob_spawn_location = $Path2D/PathFollow2D
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	enemy.position = mob_spawn_location.position
	get_tree().current_scene.add_child(enemy)

func _on_seelenbecken_completed() -> void:
	levelCompleted.emit()

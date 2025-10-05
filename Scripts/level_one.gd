extends Node2D

@export var SoulSpawnpoints: Array[Marker2D] = []
var activeMarker: Marker2D
@export var SeelenbeckenTimer: Timer

signal levelCompleted
signal soulCaptureProgressTick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand = randi_range(1,SoulSpawnpoints.size()) - 1
	activeMarker = SoulSpawnpoints[rand]
	$SeelenbeckenPos.position = activeMarker.position

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body_rid == $Player.get_rid():
		SeelenbeckenTimer.start()

func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body_rid == $Player.get_rid():
		SeelenbeckenTimer.stop()

func _on_texture_progress_bar_completed() -> void:
	levelCompleted.emit()

func _on_timer_timeout() -> void:
	soulCaptureProgressTick.emit()

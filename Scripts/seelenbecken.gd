extends Node2D

signal completed
signal timerTick

@export var TimerDuration: int = 20
@export var Player: Node2D


func _on_texture_progress_bar_completed() -> void:
	completed.emit()


func _on_timer_timeout() -> void:
	timerTick.emit()


func _on_texture_progress_bar_isready() -> void:
	$Seelenbecken/TextureProgressBar.seconds = TimerDuration	


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body_rid == Player.get_rid():
		$Seelenbecken/TextureProgressBar/Timer.start()


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body_rid == Player.get_rid():
		$Seelenbecken/TextureProgressBar/Timer.stop()

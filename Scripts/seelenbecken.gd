extends Node2D

signal completed
signal timerTick

@export var TimerDuration: int = 20
@export var Player: Node2D

var levelCompleted = false

func _on_texture_progress_bar_completed() -> void:
	$Seelenbecken/TextureProgressBar/Timer.stop()
	$Seelenbecken/SeelenbeckenRadius.visible = false
	levelCompleted = true
	completed.emit()


func _on_timer_timeout() -> void:
	timerTick.emit()


func _on_texture_progress_bar_isready() -> void:
	$Seelenbecken/TextureProgressBar.seconds = TimerDuration	


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body_rid == Player.get_rid() and not levelCompleted:
		$Seelenbecken/TextureProgressBar/Timer.start()
		$Seelenbecken/SeelenbeckenRadius.set_modulate(Color(0.0, 18.892, 18.892))


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body_rid == Player.get_rid() and not levelCompleted:
		$Seelenbecken/TextureProgressBar/Timer.stop()
		$Seelenbecken/SeelenbeckenRadius.set_modulate(Color.WHITE)

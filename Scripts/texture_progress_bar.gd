extends TextureProgressBar

@export var timeInSec: int = 20
@export var seelenbeckenTimer: Timer

signal completed

func _ready() -> void:
	step = 100/timeInSec
	


func _on_timer_timeout() -> void:
	value += step
	if value >= max_value:
		completed.emit()

extends TextureProgressBar

@export var seelenbeckenTimer: Timer
var seconds = 1

signal completed
signal isready 

func _ready() -> void:
	isready.emit()
	step = 100/seconds
	


func _on_timer_timeout() -> void:
	value += step
	if value >= max_value:
		completed.emit()

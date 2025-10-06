extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		var direction = (global_position - body.global_position).normalized()
		$"..".apply_knockback(direction)

extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Enemy":
		var direction = (global_position - body.global_position).normalized()
		$"..".apply_knockback(direction)

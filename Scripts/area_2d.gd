extends Area2D

func _on_enemy_attack(area: Area2D):
	if area.is_in_group("enemy"):
		var direction = (global_position - area.global_position).normalized()
		$"..".apply_knockback(direction)

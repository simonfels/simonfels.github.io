extends RigidBody2D

var damage = 10

func _on_wall_entered(body):
	if body.is_in_group("walls"):
		destroy_projectile()

func _on_enemy_hit(area: Area2D):
	if area.is_in_group("enemy"):
		area.get_parent().take_damage(damage)
		destroy_projectile()

func destroy_projectile() -> void:
	queue_free()

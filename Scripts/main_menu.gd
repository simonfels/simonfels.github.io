extends Node2D

func _ready():
	updateSoulLabel()

func updateSoulLabel():
	$Label2.text = str(SaveState.souls)

func _on_start_button():
	get_tree().change_scene_to_file("res://Scenes/level_one.tscn")

func _on_buy_articact1():
	if SaveState.souls >= 1:
		SaveState.souls -= 1
		SaveState.artifact1 = true
		$Artifact1.modulate = Color.WHITE
		updateSoulLabel()
		$Button5.queue_free()

func _on_buy_articact2():
	if SaveState.souls >= 2:
		SaveState.souls -= 2
		SaveState.artifact2 = true
		$Artifact2.modulate = Color.WHITE
		updateSoulLabel()
		$Button4.queue_free()

func _on_buy_articact3():
	if SaveState.souls >= 3:
		SaveState.souls -= 3
		SaveState.artifact3 = true
		$Artifact3.modulate = Color.WHITE
		updateSoulLabel()
		$Button3.queue_free()

func _on_buy_articact4():
	if SaveState.souls >= 4:
		SaveState.souls -= 4
		SaveState.artifact4 = true
		$Artifact4.modulate = Color.WHITE
		updateSoulLabel()
		$Button2.queue_free()

func _on_buy_articact5():
	if SaveState.souls >= 5:
		SaveState.souls -= 5
		SaveState.artifact5 = true
		$Artifact5.modulate = Color.WHITE
		updateSoulLabel()
		$Button.queue_free()

func _on_button_5_mouse_entered():
	$Doublejump.visible = true

func _on_button_5_mouse_exited():
	$Doublejump.visible = false

func _on_button_4_mouse_entered():
	$"2Xatkspd".visible = true

func _on_button_4_mouse_exited():
	$"2Xatkspd".visible = false

func _on_button_3_mouse_entered():
	$Projectile.visible = true

func _on_button_3_mouse_exited():
	$Projectile.visible = false

func _on_button_2_mouse_entered():
	$"2Xdmg".visible = true

func _on_button_2_mouse_exited():
	$"2Xdmg".visible = false

func _on_button_mouse_entered():
	$Youwin.visible = true

func _on_button_mouse_exited():
	$Youwin.visible = false

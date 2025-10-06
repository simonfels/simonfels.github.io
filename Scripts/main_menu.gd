extends Node2D

func _on_start_button():
	get_tree().change_scene_to_file("res://Scenes/level_one.tscn")

func _on_buy_articact1():
	if SaveState.souls >= 1:
		SaveState.souls -= 1
		SaveState.artifact1 = true
		$Artifact1.modulate = Color.WHITE

func _on_buy_articact2():
	if SaveState.souls >= 2:
		SaveState.souls -= 2
		SaveState.artifact2 = true
		$Artifact2.modulate = Color.WHITE

func _on_buy_articact3():
	if SaveState.souls >= 3:
		SaveState.souls -= 3
		SaveState.artifact3 = true
		$Artifact3.modulate = Color.WHITE

func _on_buy_articact4():
	if SaveState.souls >= 4:
		SaveState.souls -= 4
		SaveState.artifact4 = true
		$Artifact4.modulate = Color.WHITE

func _on_buy_articact5():
	if SaveState.souls >= 5:
		SaveState.souls -= 5
		SaveState.artifact5 = true
		$Artifact5.modulate = Color.WHITE

extends Node2D

func _on_start_button():
	get_tree().change_scene_to_file("res://Scenes/level_one.tscn")

func _on_buy_articact1():
	SaveState.buyArtifact1()
	$Artifact1.modulate = Color.WHITE

func _on_buy_articact2():
	SaveState.buyArtifact2()
	$Artifact2.modulate = Color.WHITE

func _on_buy_articact3():
	SaveState.buyArtifact3()
	$Artifact3.modulate = Color.WHITE

func _on_buy_articact4():
	SaveState.buyArtifact4()
	$Artifact4.modulate = Color.WHITE

func _on_buy_articact5():
	SaveState.buyArtifact5()
	$Artifact5.modulate = Color.WHITE

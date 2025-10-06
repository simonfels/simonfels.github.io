extends Node2D

func _on_start_button():
	get_tree().change_scene_to_file("res://Scenes/level_one.tscn")

func _on_buy_articact1():
	SaveState.buyArtifact1()

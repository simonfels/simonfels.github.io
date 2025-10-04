extends Node2D

@export var SoulSpawnpoints: Array[Marker2D] = []
var activeMarker: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand = randi_range(1,SoulSpawnpoints.size()) - 1
	activeMarker = SoulSpawnpoints[rand]
	$SeelenbeckenPos.position = activeMarker.position

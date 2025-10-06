extends Node

var artifact1 = false
var artifact2 = false
var artifact3 = false
var artifact4 = false
var artifact5 = false
var level = 1
var souls = 4

func nextLevel() -> void:
	level += 1

func addSoul() -> void:
	souls += 1

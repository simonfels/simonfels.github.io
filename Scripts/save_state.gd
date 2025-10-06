extends Node

var artifact1 = false
var artifact2 = false
var artifact3 = false
var artifact4 = false
var artifact5 = false
var level = 1
var souls = 0

func buyArtifact1() -> void:
	if souls >= 1:
		souls -= 1
		artifact1 = true

func buyArtifact2() -> void:
	if souls >= 2:
		souls -= 2
		artifact2 = true

func buyArtifact3() -> void:
	if souls >= 3:
		souls -= 3
		artifact3 = true

func buyArtifact4() -> void:
	if souls >= 4:
		souls -= 4
		artifact4 = true

func buyArtifact5() -> void:
	if souls >= 5:
		souls -= 5
		artifact5 = true

func nextLevel() -> void:
	level += 1

func addSoul() -> void:
	souls += 1

extends Camera2D

@export var player : CharacterBody2D
var cutscene : bool = false

func _process(_delta):
	if player != null and !cutscene:
		global_position = player.global_position

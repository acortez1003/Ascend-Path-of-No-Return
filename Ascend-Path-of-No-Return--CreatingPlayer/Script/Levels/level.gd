extends Node2D

@onready var cutscene = $AnimationPlayer
static var cutscene_played = false

func _ready():
	if SceneManager.spawn_door_destination != null:
		_on_level_spawn(SceneManager.spawn_door_destination)
	
	if has_node("ColorRect"):
		if cutscene_played:
			$ColorRect.visible = false
		else:
			$ColorRect.visible = true
		
	SceneManager.connect("cutscene_1", Callable(self, "_on_cutscene_1"))

func _on_level_spawn(scene_path : String):
	var door_path = "Doors/Door_" + scene_path
	var door = get_node(door_path) as Door
	SceneManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

func _on_cutscene_1():
	cutscene.play("open_cutscene")
	await cutscene.animation_finished
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/open_cutscene.dialogue"), "next")
	cutscene_played = true

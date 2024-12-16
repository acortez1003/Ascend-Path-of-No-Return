extends Node

var scenes : Dictionary = {"Area1": "res://Levels/prison_level.tscn",
						   "Area2": "res://Levels/cave_level.tscn",
						   "Area3": "res://Levels/forest_level.tscn",
						   "Area4": "res://Levels/castle_level.tscn"}
var player : CharacterBody2D
signal on_trigger_player_spawn
signal cutscene_1
var spawn_door_destination
var current_scene : String = ""

func transition_to_scene(level : String, door_destination : String):
	var scene_path : String = scenes.get(level)
	
	if scene_path != null:
		spawn_door_destination = door_destination
		current_scene = level
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file(scene_path)

func trigger_player_spawn(position : Vector2, direction : String):
	on_trigger_player_spawn.emit(position, direction)

#for debugging
func get_current_scene() -> String:
	return current_scene

func open_cutscene():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	player.can_move = false
	await get_tree().create_timer(0.5).timeout # need time to make connection
	print("signal emitted")
	emit_signal("cutscene_1")

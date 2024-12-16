extends Node2D
class_name Door

@export var next_scene : String
@export var door_destination : String
@export var spawn_direction = "up"
@onready var spawn = $Spawn

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("player passed through door")
		var player = body as CharacterBody2D
		player.queue_free()
		await get_tree().create_timer(0.5).timeout
		print("scene transition")
		SceneManager.transition_to_scene(next_scene, door_destination)

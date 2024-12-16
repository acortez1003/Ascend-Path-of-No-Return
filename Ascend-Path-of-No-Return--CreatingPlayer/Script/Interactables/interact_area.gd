extends Node

@export var dialogue_resource : DialogueResource
@export var dialogue_start : String = "start"
@onready var player = get_tree().get_first_node_in_group("Player")
var nearby_interactables = []

func _ready() -> void:
	DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_ended"))

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		interact_with_nearby()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$Label.show()
		nearby_interactables.append(get_parent())

func _on_body_exited(body):
	if body.is_in_group("Player"):
		$Label.hide()
		nearby_interactables.erase(get_parent())

func interact_with_nearby():
	if nearby_interactables.size() > 0:
		nearby_interactables[0].interact()

func interact():
	if is_instance_valid(player):
		player.can_move = false
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func disable_interact():
	$CollisionShape2D.disabled = true

func enable_interact():
	$CollisionShape2D.disabled = false

func _on_dialogue_ended(dialogue_resource):
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	player.can_move = true

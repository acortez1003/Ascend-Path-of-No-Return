extends "res://Script/Interactables/interact_area.gd"

func _ready() -> void:
	var state_manager = get_node("/root/StateManager")
	state_manager.connect("chest_open", Callable(self, "_on_chest_open"))

func _on_chest_open():
	$AnimationPlayer.play("open_chest")

extends "res://Script/Interactables/interact_area.gd"

static var full = false

func _ready() -> void:
	if full:
		$full.show()
	var state_manager = get_node("/root/StateManager")
	state_manager.connect("full_cauldron", Callable(self, "_on_full_cauldron"))

func _on_full_cauldron():
	$full.show()
	full = true
	$InteractArea.disable_interact()

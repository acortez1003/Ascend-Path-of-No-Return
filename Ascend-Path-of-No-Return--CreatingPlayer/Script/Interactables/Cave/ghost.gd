extends "res://Script/Interactables/interact_area.gd"

static var quest_1_complete = false

func _ready() -> void:
	if quest_1_complete:
		self.queue_free()
	var state_manager = get_node("/root/StateManager")
	state_manager.connect("remove_ghost", Callable(self, "_on_remove_ghost"))

func _on_remove_ghost():
	quest_1_complete = true
	self.queue_free()

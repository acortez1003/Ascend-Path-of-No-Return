extends "res://Script/Interactables/interact_area.gd"

static var unlocked = false

func _ready() -> void:
	if unlocked:
		self.queue_free()
	var state_manager = get_node("/root/StateManager")
	state_manager.connect("remove_lock", Callable(self, "_on_remove_lock"))

func _on_remove_lock():
	unlocked = true
	self.queue_free()

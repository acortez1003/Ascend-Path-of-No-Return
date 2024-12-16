extends "res://Script/Interactables/interact_area.gd"

static var vines_gone = false

func _ready() -> void:
	if vines_gone:
		self.queue_free()
	var state_manager = get_node("/root/StateManager")
	state_manager.connect("remove_vines", Callable(self, "_on_remove_vines"))

func _on_remove_vines():
	vines_gone = true
	self.queue_free()

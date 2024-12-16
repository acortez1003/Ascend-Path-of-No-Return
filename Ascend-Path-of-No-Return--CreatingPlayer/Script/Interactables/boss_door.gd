extends "res://Script/Interactables/interact_area.gd"

static var is_open = false

func _ready():
	InventoryManager.add_to_inventory("10", "matriarch_key")
	InventoryManager.add_to_inventory("11", "grizzly_key")
	if is_open:
		_on_open_door()
	var state_manager = get_node("/root/StateManager")
	state_manager.connect("open_door", Callable(self, "_on_open_door"))

func _on_open_door():
	is_open = true
	$door_closed.hide()
	$StaticBody2D/CollisionShape2D.disabled = true
	$door_open.show()
	$InteractArea.disable_interact()

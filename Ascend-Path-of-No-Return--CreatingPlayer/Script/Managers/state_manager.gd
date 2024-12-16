extends Node

# Prison
signal chest_open
var has_prison_key = false

func open_chest():
	emit_signal("chest_open")

func take_key():
	InventoryManager.add_to_inventory("0", "prison_key")
	has_prison_key = true

# Cave
var picked_up_medallion = false
var placed_medallion = false
signal remove_ghost

func delete_ghost():
	emit_signal("remove_ghost")

# Forest
signal remove_vines
var prisoner_free = false
var has_key = false
signal full_cauldron
signal remove_lock

# Forest
func delete_vines():
	prisoner_free = true
	emit_signal("remove_vines")

func change_cauldron():
	emit_signal("full_cauldron")

func delete_lock():
	emit_signal("remove_lock")

# Castle
signal open_door

func change_door():
	emit_signal("open_door")

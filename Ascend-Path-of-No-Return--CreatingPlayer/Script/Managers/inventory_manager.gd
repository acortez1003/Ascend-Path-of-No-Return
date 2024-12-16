extends Node

var inventory : Dictionary

#id is the key, type is the value
func add_to_inventory(id : String, type : String):
	inventory[id] = type

func has_inventory_item(id : String) -> bool:
	return inventory.has(id)

func remove_from_inventory(id : String):
	if has_inventory_item(id):
		inventory.erase(id)

# for debugging
func print_inventory():
	if inventory.size() == 0:
		print("Inventory is empty.")
	else:
		print("Current Inventory:")
		for key in inventory.keys():
			print("- %s: %s" % [key, inventory[key]])

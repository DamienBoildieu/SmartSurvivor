class_name Inventory
extends Resource


signal drop_item(item: Item, amount: int)
signal inventory_changed()


var items: Dictionary = {}


func add_item(item, amount: int):
	var current_amount = items.get(item, 0)
	items[item] = current_amount + amount
	inventory_changed.emit()


func drop(item, amount):
	var current_amount = items.get(item, 0)
	if amount > current_amount:
		print_debug("You don't have that much of %s", item.name)
	if current_amount != 0:
		if amount >= current_amount:
			items.erase(item)
		else:
			items[item] -= amount
		drop_item.emit(item, amount)
		inventory_changed.emit()


func get_amount(item) -> int:
	return items.get(item, 0)


func has_all(requirements: Dictionary) -> bool:
	for item in requirements:
		if items.get(item, 0) < requirements[item]:
			return false
	return true


func remove_items(to_remove: Dictionary) -> void:
	for item in to_remove:
		items[item] -= to_remove[item]
		if items[item] < 0:
			items[item] = 0
	inventory_changed.emit()

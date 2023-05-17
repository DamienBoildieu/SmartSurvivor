class_name Inventory
extends Node


signal inventory_changed(items: Inventory)


var items: Dictionary = {}
# @onready var drop_item: DropItem = $DropItem


func add_item(item, amount: int):
	var current_amount = items.get(item, 0)
	items[item] = current_amount + amount
	inventory_changed.emit(self)


func drop(item, amount):
	var current_amount = items.get(item, 0)
	if amount > current_amount:
		print_debug("You don't have that much of %s", item.name)
	if current_amount != 0:
		if amount >= current_amount:
			items.erase(item)
		else:
			items[item] -= amount
		GlobalDropItem.drop_item(item, amount, owner.position)
		inventory_changed.emit(self)
		# drop_item.drop_item(item, amount, owner.position)


func get_amount(item) -> int:
	return items.get(item, 0)

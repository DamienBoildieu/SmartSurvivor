extends Node

class_name Inventory


var items: Dictionary = {}
# @onready var drop_item: DropItem = $DropItem


func add_item(item, amount: int):
	print_debug(items)
	var current_amount = items.get(item, 0)
	items[item] = current_amount + amount
	print_debug(items)


func drop(item, amount):
	var current_amount = items.get(item, 0)
	if amount > current_amount:
		print("You don't have that much of %s", item.name)
	if current_amount != 0:
		if amount >= current_amount:
			items.erase(item)
		else:
			items[item] -= amount
		GlobalDropItem.drop_item(item, amount, owner.position)
		# drop_item.drop_item(item, amount, owner.position)


func get_amount(item) -> int:
	return items.get(item, 0)

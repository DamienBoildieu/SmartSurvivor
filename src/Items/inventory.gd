extends Node

class_name Inventory


var items: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_item(item, amount: int):
	var current_amount = items.get(item, 0)
	items[item] = current_amount + amount


func drop_item(item, amount):
	var current_amount = items.get(item, 0)
	if amount > current_amount:
		print("You don't have that much of %s", item.name)
	if current_amount != 0:
		if amount >= current_amount:
			items.erase(item)
		else:
			items[item] -= amount


func get_amount(item) -> int:
	return items.get(item, 0)

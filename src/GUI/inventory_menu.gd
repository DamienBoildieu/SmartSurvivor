class_name InventoryMenu
extends MarginContainer


@onready var grid: GridContainer = $Panel/VBoxContainer/GridContainer


var inventory_item_template: PackedScene = preload("res://src/GUI/inventory_item.tscn")
var inventory: Inventory


func setup_inventory(new_inventory: Inventory) -> void:
	inventory = new_inventory
	for c_node in grid.get_children():
		c_node.queue_free()
	
	for item in inventory.items:
		var item_icon = inventory_item_template.instantiate()
		item_icon.item = item
		item_icon.quantity = inventory.items[item]
		
		grid.add_child(item_icon)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_inventory_changed(new_inventory: Inventory) -> void:
	setup_inventory(new_inventory)


func _on_item_clicked(inventory_item: InventoryItem) -> void:
	pass

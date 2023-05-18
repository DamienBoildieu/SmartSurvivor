class_name InventoryMenu
extends PanelContainer


@onready var grid: GridContainer = $VBoxContainer/HSplitContainer/GridContainer
@onready var item_panel: ItemPanel = $VBoxContainer/HSplitContainer/ItemPanel


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
		item_icon.item_clicked.connect(_on_item_clicked)
		grid.add_child(item_icon)


func _on_inventory_changed(new_inventory: Inventory) -> void:
	setup_inventory(new_inventory)
	item_panel.hide()


func _on_item_clicked(inventory_item: InventoryItem) -> void:
	item_panel.item = inventory_item.item
	item_panel.quantity = inventory_item.quantity
	item_panel.show()


func _on_visibility_changed():
	if item_panel != null:
		item_panel.hide()


func _on_item_panel_drop_item(item, quantity):
	inventory.drop(item, quantity)

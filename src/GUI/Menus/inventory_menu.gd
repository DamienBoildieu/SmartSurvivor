class_name InventoryMenu
extends HSplitContainer


@onready var grid: GridContainer = $GridContainer
@onready var item_panel: ItemPanel = $ItemPanel


var inventory_item_template: PackedScene = preload("res://src/GUI/Menus/inventory_item.tscn")
var inventory: Inventory

func setup_inventory(player: TopDownCharacter) -> void:
	if player.inventory != inventory:
		if inventory != null:
			inventory.inventory_changed.disconnect(_on_inventory_changed)
		inventory = player.inventory
		inventory.inventory_changed.connect(_on_inventory_changed)
		item_panel.use_item.connect(player._on_use_item)
		item_panel.drop_item.connect(player._on_drop_item)
	refresh_inventory()


func refresh_inventory() -> void:
	for c_node in grid.get_children():
		c_node.queue_free()
	
	for item in inventory.items:
		var item_icon = inventory_item_template.instantiate()
		item_icon.item = item
		item_icon.quantity = inventory.items[item]
		item_icon.item_clicked.connect(_on_item_clicked)
		grid.add_child(item_icon)


func _on_inventory_changed() -> void:
	refresh_inventory()
	item_panel.hide()


func _on_item_clicked(inventory_item: InventoryItem) -> void:
	item_panel.item = inventory_item.item
	item_panel.quantity = inventory_item.quantity
	item_panel.show()


func _on_visibility_changed():
	if item_panel != null:
		item_panel.hide()

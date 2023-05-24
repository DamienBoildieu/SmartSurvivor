class_name InventoryItem
extends PanelContainer


signal item_clicked(item: InventoryItem)


@export var item: Item:
	get:
		return item
	set(new_item):
		item = new_item
		if is_ready:
			update_item()
@export var quantity: int:
	get:
		return quantity
	set(new_quantity):
		quantity = new_quantity
		if is_ready:
			update_quantity()


var sprite: TextureRect
var label: Label
var is_ready: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $HBoxContainer/TextureRect
	label = $HBoxContainer/Label
	is_ready = true
	update_item()
	update_quantity()


func update_item() -> void:
	sprite.texture = item.texture
	tooltip_text = item.description


func update_quantity() -> void:
	label.text = str(quantity)


func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			item_clicked.emit(self)

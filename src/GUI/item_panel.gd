class_name ItemPanel
extends PanelContainer


signal drop_item(item: Item, quantity: int)


@export var item: Item:
	get:
		return item
	set(new_item):
		item = new_item
		if is_ready:
			update_item()
@export var quantity: int = 0:
	get:
		return quantity
	set(new_quantity):
		quantity = new_quantity
		if is_ready:
			update_quantity()


var name_label: RichTextLabel
var description_label:Label
var quantity_label: Label
var use_button: Button
var drop_button: Button
var is_ready: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	name_label = $VBoxContainer/NameLabel
	description_label = $VBoxContainer/DescriptionLabel
	quantity_label = $VBoxContainer/QuantityLabel
	use_button = $VBoxContainer/HBoxContainer/UseButton
	drop_button = $VBoxContainer/HBoxContainer/DropButton
	is_ready = true
	update_item()


func update_item() -> void:
	name_label.clear()
	if item != null:
		name_label.add_image(item.texture)
		name_label.add_text(item.name)
		description_label.text = item.description
		use_button.disabled = not item.usable


func update_quantity() -> void:
	if quantity != 0:
		quantity_label.text = "Quantity: "+str(quantity)


func clear() -> void:
	name_label.clear()
	description_label.clear()
	quantity_label.clear()


func _on_drop_button_pressed():
	drop_item.emit(item, quantity)

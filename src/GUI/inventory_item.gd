class_name InventoryItem
extends ReferenceRect


@export var item: Item:
	get:
		return item
	set(new_item):
		item = new_item
		if is_ready:
			update_item()


@onready var sprite: Sprite2D
@onready var label: Label

var is_ready: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Sprite2D
	label = $Label
	is_ready = true
	update_item()


func update_item() -> void:
	sprite.texture = item.sprite.texture
	sprite.region_enabled = item.sprite.region_enabled
	sprite.region_rect = item.sprite.region_rect
	sprite.scale = item.sprite.scale


func _on_mouse_entered():
	pass # Replace with function body.


func _on_mouse_exited():
	pass # Replace with function body.


func _on_gui_input(event):
	pass # Replace with function body.

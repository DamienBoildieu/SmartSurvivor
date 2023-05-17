class_name PickableItem
extends Area2D


@export var default_quantity: int = 1
@export var item: Item:
	get:
		return item
	set(new_item):
		item = new_item
		if is_ready:
			update_item()


var quantity: int = 0
var is_ready: bool = false
var sprite: Sprite2D
var collision_shape: CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Sprite2D
	collision_shape = $CollisionShape2D
	if quantity == 0:
		quantity = default_quantity
	is_ready = true
	update_item()


func update_item() -> void:
	scale = item.scale
	sprite.texture = item.texture
	collision_shape.shape.size = item.texture.get_size()

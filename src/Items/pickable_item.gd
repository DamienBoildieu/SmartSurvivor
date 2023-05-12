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
	sprite.texture = item.texture
	sprite.region_enabled = true
	sprite.region_rect = item.rect
	sprite.scale = item.scale
	collision_shape.shape.size = Vector2(item.rect.size)
	collision_shape.scale = item.scale

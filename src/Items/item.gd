class_name Item
extends Resource


@export var name: String = "Item name"
@export var description: String = "Description"
@export var texture: Texture = preload("res://src/Items/default_item_atlas.tres")
# Default scale for sprites to 0.5 as items assets are 32 pixels size while  are 16 pixels size
@export var scale: Vector2 = Vector2(0.5, 0.5)
@export var stackable: bool = true

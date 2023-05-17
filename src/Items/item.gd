class_name Item
extends Resource


@export var name: String = "Item name"
@export var description: String = "Description"
@export var texture: Texture = preload("res://assets/Shikashi's Fantasy Icons Pack v2/#1 - Transparent Icons.png")
@export var rect: Rect2 = Rect2(0, 0, 32, 32)
# Default to 0.5 as items assets are 32 pixels size while tilesets and character are 16 pixels size
@export var scale: Vector2 = Vector2(0.5, 0.5)
@export var stackable: bool = true

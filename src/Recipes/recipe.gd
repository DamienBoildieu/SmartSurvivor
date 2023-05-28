class_name Recipe
extends Resource


@export var name: String = "Item name"
@export var description: String = "Description"
@export var construction_time: float = 1.0
@export var texture: Texture = preload("res://src/Items/default_item_atlas.tres")
@export var requires: Dictionary = {}
@export var building: PackedScene

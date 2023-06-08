class_name PlaceArea
extends Area2D


signal build(recipe: Recipe)
signal cancel()


@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
var recipe: Recipe


func update(new_recipe: Recipe) -> void:
	sprite.texture = new_recipe.texture
	collision_shape.shape.size = new_recipe.texture.get_size()
	recipe = new_recipe


func activate() -> void:
	collision_shape.disabled = false
	visible = true


func deactivate() -> void:
	collision_shape.disabled = true
	visible = false


func build_scene() -> void:
	print_debug(recipe)
	build.emit(recipe)


func cancel_build() -> void:
	cancel.emit()

class_name InteractableModulate
extends Interactable


@export var modulate_color: Color = Color(1., 1., 1., 0.5)


var sprite: Sprite2D


func _setup(params: Dictionary = {}) -> void:
	sprite = params["sprite"]


func _select() -> void:
	sprite.modulate = modulate_color


func _unselect() -> void:
	sprite.modulate = Color.WHITE

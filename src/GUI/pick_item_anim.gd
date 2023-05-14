class_name PickItemAnim
extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var animation_name: String = "default"
@export var item: PickableItem:
	get:
		return item
	set(new_item):
		item = new_item
		if is_ready:
			update_item()


var is_ready: bool = false
var sprite: Sprite2D
var label: Label


func _ready():
	sprite = $DisplayContainer/HBoxContainer/Control/Sprite2D
	label = $DisplayContainer/HBoxContainer/Label
	is_ready = true
	update_item()


func update_item() -> void:
	sprite.texture = item.sprite.texture
	sprite.region_enabled = item.sprite.region_enabled
	sprite.region_rect = item.sprite.region_rect
	sprite.scale = item.sprite.scale
	label.text = str(item.quantity)


func play_anim() -> void:
	animation_player.play(animation_name)


func _on_animation_player_animation_finished(anim_name):
	var parent: Node = get_parent()
	if parent != null:
		parent.remove_child(self)
	GlobalItemAnimPool.add_object(self)

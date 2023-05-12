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
	sprite = $DisplayContainer/Sprite2D
	label = $DisplayContainer/Label
	is_ready = true
	update_item()


func update_item() -> void:
	sprite = item.sprite
	label.text = str(item.quantity)


func play_anim() -> void:
	animation_player.play(animation_name)


func _on_animation_player_animation_finished(anim_name):
	GlobalItemAnimPool.add_object(self)

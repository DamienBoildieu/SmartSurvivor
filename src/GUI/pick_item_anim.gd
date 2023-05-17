class_name PickItemAnim
extends Node2D


signal anim_finished(anim: PickItemAnim)


@export var animation_name: String = "default"
@export var item: PickableItem:
	get:
		return item
	set(new_item):
		item = new_item
		if is_ready:
			update_item()


@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_ready: bool = false
var sprite: TextureRect
var label: Label
var rich_text_label: RichTextLabel


func _ready():
	sprite = $DisplayContainer/HBoxContainer/TextureRect
	label = $DisplayContainer/HBoxContainer/Label
	is_ready = true
	update_item()


func update_item() -> void:
	label.text = str(item.quantity)
	sprite.texture = item.sprite.texture


func play_anim() -> void:
	animation_player.play(animation_name)


func _on_animation_player_animation_finished(_anim_name):
	anim_finished.emit(self)

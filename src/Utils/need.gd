class_name Need
extends Node


signal need_updated(new_value: int)
signal lack_need


@export var max_need: int = 5
@export var autoupdate: bool = true:
	get:
		return autoupdate
	set(value):
		autoupdate = value
		if autoupdate:
			timer.start()
		else:
			timer.stop()


@onready var need_value: int = max_need
@onready var timer: Timer = $Timer


func _ready() -> void:
	if autoupdate:
		timer.start()


func reduce_need(modifier: int) -> void:
	if need_value > 0:
		need_value -= modifier
		need_updated.emit(need_value)
	else:
		lack_need.emit()


func improve_need(modifier: int) -> void:
	need_value += modifier
	need_updated.emit(need_value)


func _on_timer_timeout():
	reduce_need(1)

class_name GenericPool
extends Node


@export var obj_template: PackedScene
@export var pool_size: int = 20
var pool: Array[Node] = []



func get_object() -> Node:
	if pool.is_empty():
		return obj_template.instantiate()
	else:
		return pool.pop_back()


func add_object(obj: Node) -> void:
	if pool.size() < pool_size:
		pool.push_back(obj)
	else:
		obj.queue_free()

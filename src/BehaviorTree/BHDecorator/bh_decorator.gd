class_name BHDecorator extends BHNode


@export var child: BHNode


func _abort() -> void:
	child._abort()
	to_abort = true

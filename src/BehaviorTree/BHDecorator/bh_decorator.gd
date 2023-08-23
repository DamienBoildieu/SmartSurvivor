class_name BHDecorator extends BHNode


@export var child: BHNode


func _setup(args: Dictionary) -> void:
	child._setup(args)


func _abort() -> void:
	child._abort()
	to_abort = true

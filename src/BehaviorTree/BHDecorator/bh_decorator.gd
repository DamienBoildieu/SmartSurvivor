class_name BHDecorator extends BHNode


@export var child: BHNode


func _setup(args: Dictionary) -> void:
	child._setup(args)


func _abort() -> void:
	child._abort()
	to_abort = true


func _process(func_name: String, delta: float) -> StateEnum:
	return child.call(func_name, delta) as StateEnum

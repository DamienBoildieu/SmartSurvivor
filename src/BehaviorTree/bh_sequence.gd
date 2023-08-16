class_name BHSequence extends BHNode


@export var sequence_type: StateEnum = StateEnum.SUCCESS
@export var children: Array[BHNode]


func _setup(args: Dictionary) -> void:
	for child in children:
		child._setup(args)


func _process(func_name: String, delta: float) -> StateEnum:
	for child in children:
		var ret_code := child.call(func_name, delta) as StateEnum
		if ret_code != sequence_type:
			return ret_code
	return sequence_type

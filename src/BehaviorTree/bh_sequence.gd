class_name BHSequence extends BHNode


@export var sequence_type: StateEnum = StateEnum.SUCCESS
@export var children: Array[BHNode]


func _setup(args: Dictionary) -> void:
	for child in children:
		child._setup(args)


func _process_node(delta: float) -> StateEnum:
	for child in children:
		var ret_code := child._process_node(delta)
		if ret_code != sequence_type:
			return ret_code
	return sequence_type


func _process_physics_node(delta: float) -> StateEnum:
	for child in children:
		var ret_code := child._process_physics_node(delta)
		if ret_code != sequence_type:
			return ret_code
	return sequence_type

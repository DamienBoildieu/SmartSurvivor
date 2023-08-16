class_name BHSequence extends BHNode


@export var sequence_type: StateEnum = StateEnum.SUCCESS
@export var children: Array[BHNode]


var current_child := 0
var last_result: StateEnum


func _setup(args: Dictionary) -> void:
	for child in children:
		child._setup(args)


func _abort() -> void:
	if last_result == StateEnum.RUNNING:
		children[current_child]._abort()
	to_abort = true


func _process(func_name: String, delta: float) -> StateEnum:
	var ret_code := sequence_type
	while ret_code == sequence_type and current_child < children.size():
		ret_code = children[current_child].call(func_name, delta) as StateEnum
		current_child += 1
	if current_child == children.size() or ret_code != StateEnum.RUNNING:
		current_child = 0
	last_result = ret_code
	return ret_code

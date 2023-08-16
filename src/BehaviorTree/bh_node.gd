class_name BHNode extends Resource


enum StateEnum {
	SUCCESS,
	FAIL,
	RUNNING
}


func _setup(_args: Dictionary) -> void:
	pass


func _process(_func_name: String, _delta: float) -> StateEnum:
	return StateEnum.SUCCESS

# Default behavior calls same method for process and physics process to simplify sequence and decorator nodes
func _process_node(delta: float) -> StateEnum:
	return _process("_process_node", delta)


func _process_physics_node(delta: float) -> StateEnum:
	return _process("_process_physics_node", delta)

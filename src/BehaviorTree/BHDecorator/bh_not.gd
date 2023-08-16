class_name BHNot extends BHDecorator


func negate(ret_code: StateEnum) -> StateEnum:
	if ret_code == StateEnum.SUCCESS:
		return StateEnum.FAIL
	elif ret_code == StateEnum.FAIL:
		return StateEnum.SUCCESS
	else:
		return ret_code


func _process_node(delta: float) -> StateEnum:
	return negate(child._process_node(delta))


func _process_physics_node(delta: float) -> StateEnum:
	return negate(child._process_node(delta))

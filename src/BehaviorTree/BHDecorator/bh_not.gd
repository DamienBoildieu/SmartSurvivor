class_name BHNot extends BHDecorator


func negate(ret_code: StateEnum) -> StateEnum:
	if ret_code == StateEnum.SUCCESS:
		return StateEnum.FAIL
	elif ret_code == StateEnum.FAIL:
		return StateEnum.SUCCESS
	else:
		return ret_code


func _process(func_name, delta: float) -> StateEnum:
	return negate(child.call(func_name, delta) as StateEnum)

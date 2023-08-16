class_name BHCondition extends BHDecorator


func _condition(_delta: float) -> bool:
	return true


func _process(func_name: String, delta: float) -> StateEnum:
	if _condition(delta):
		return child.call(func_name, delta) as StateEnum
	else:
		return StateEnum.FAIL

class_name BHCondition extends BHDecorator


func _condition(_delta: float) -> bool:
	return true


func _process_node(delta: float) -> StateEnum:
	if _condition(delta):
		return child._process_node(delta)
	else:
		return StateEnum.FAIL


func _process_physics_node(delta: float) -> StateEnum:
	if _condition(delta):
		return child._process_physics_node(delta)
	else:
		return StateEnum.FAIL

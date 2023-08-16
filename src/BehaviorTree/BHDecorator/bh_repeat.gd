class_name BHRepeat extends BHDecorator


@export var nb_repeat := 1
var nb_execution := 0
var nb_physics_execution := 0


func _process_node(delta: float) -> StateEnum:
	if nb_execution < nb_repeat:
		nb_execution += 1
		return child._process_node(delta)
	else:
		return StateEnum.FAIL


func _process_physics_node(delta: float) -> StateEnum:
	if nb_physics_execution < nb_repeat:
		nb_physics_execution += 1
		return child._process_physics_node(delta)
	else:
		return StateEnum.FAIL

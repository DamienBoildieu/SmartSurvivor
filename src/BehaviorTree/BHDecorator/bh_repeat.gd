class_name BHRepeat extends BHDecorator


@export var nb_repeat := 1
var nb_execution := 0
var nb_physics_execution := 0


func _process(func_name: String, delta: float) -> StateEnum:
	if nb_execution < nb_repeat:
		nb_execution += 1
		return child.call(func_name, delta) as StateEnum
	else:
		return StateEnum.FAIL

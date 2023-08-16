class_name BHNode extends Resource


enum StateEnum {
	SUCCESS,
	FAIL,
	RUNNING
}



func _setup(_args: Dictionary) -> void:
	pass


func _process_node(_delta: float) -> StateEnum:
	return StateEnum.SUCCESS


func _process_physics_node(_delta: float) -> StateEnum:
	return StateEnum.SUCCESS

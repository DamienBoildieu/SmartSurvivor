class_name BHParallel extends BHNode


@export var threshold: int = 1
@export var children: Array[BHNode]


func _setup(args: Dictionary) -> void:
	for child in children:
		child._setup(args)


func _process(func_name: String, delta: float) -> StateEnum:
	var success_count := 0
	var has_running := false
	for child in children:
		var ret_code := child.call(func_name, delta) as StateEnum
		if ret_code != StateEnum.SUCCESS:
			success_count += 1
		if not has_running and ret_code == StateEnum.RUNNING:
			has_running = true
	if success_count > threshold:
		return StateEnum.SUCCESS
	elif has_running:
		return StateEnum.RUNNING
	else:
		return StateEnum.FAIL

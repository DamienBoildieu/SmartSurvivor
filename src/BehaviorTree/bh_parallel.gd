class_name BHParallel extends BHNode


@export var success_threshold := 1
@export var failure_threshold := 1
@export var children: Array[BHNode]


var running_children: Array[int]
var success_count := 0
var failure_count := 0


func _setup(args: Dictionary) -> void:
	for child in children:
		child._setup(args)


func clear() -> void:
	success_count = 0
	failure_count = 0
	for child_idx in running_children:
		children[child_idx]._abort()
	running_children.clear()


func _abort() -> void:
	clear()
	to_abort = true


func process_running_child(func_name: String, delta: float) -> void:
	var idx_to_remove : Array[int]
	for idx in running_children.size():
		var child_idx = running_children[idx]
		var ret_code := children[child_idx].call(func_name, delta) as StateEnum
		if ret_code != StateEnum.RUNNING:
			idx_to_remove.push_back(idx)
			if ret_code == StateEnum.SUCCESS:
				success_count += 1
			elif ret_code == StateEnum.FAIL:
				failure_count += 1
	for to_remove in idx_to_remove:
		running_children.remove_at(to_remove)


func start_parallel(func_name: String, delta: float) -> void:
	for child_idx in children.size():
			var ret_code := children[child_idx].call(func_name, delta) as StateEnum
			if ret_code == StateEnum.SUCCESS:
				success_count += 1
			if ret_code == StateEnum.RUNNING:
				running_children.push_back(child_idx)


func _process(func_name: String, delta: float) -> StateEnum:
	var has_running := false
	if not running_children.is_empty():
		process_running_child(func_name, delta)
	else:
		start_parallel(func_name, delta)
	if success_count > success_threshold:
		clear()
		return StateEnum.SUCCESS
	elif failure_count > failure_threshold:
		clear()
		return StateEnum.FAIL
	elif has_running:
		return StateEnum.RUNNING
	else:
		print_debug("Thresholds set up in a way neither of them can be achieved")
		clear()
		return StateEnum.FAIL

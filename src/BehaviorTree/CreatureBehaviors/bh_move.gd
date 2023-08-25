class_name BHMove extends BHCreature


var last_state := StateEnum.SUCCESS
var targets: Array[Vector2] = [Vector2(150., 150.), Vector2(250., 250.)]
var curr_target_idx := 0


func _setup(args: Dictionary) -> void:
	super(args)
	await pawn.get_tree().physics_frame


func _process_physics_node(_delta: float) -> StateEnum:
	if last_state != StateEnum.RUNNING:
		curr_target_idx = (curr_target_idx +1) % 2
		pawn.navigation_agent.target_position = targets[curr_target_idx]
	if pawn.navigation_agent.is_navigation_finished():
		last_state = StateEnum.SUCCESS
		pawn.velocity = Vector2.ZERO
	else:
		var velocity := pawn.navigation_agent.get_next_path_position() - pawn.global_position
		velocity = velocity.normalized()
		velocity = velocity * pawn.speed
		pawn.velocity = velocity
		last_state = StateEnum.RUNNING
	return last_state

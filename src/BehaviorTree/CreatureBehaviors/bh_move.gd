class_name BHMove extends BHCreature


@export var nav_region: NavigationRegion2D


var last_state := StateEnum.SUCCESS
var server_init := false

func _setup(args: Dictionary) -> void:
	super(args)
	if nav_region == null:
		nav_region = args.get("nav_region") as NavigationRegion2D
		if nav_region == null:
			print_debug("No navigation region defined")
			return


func _process_physics_node(_delta: float) -> StateEnum:
	if not server_init:
		await pawn.get_tree().physics_frame
		server_init = true
	if last_state != StateEnum.RUNNING:
		pass
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

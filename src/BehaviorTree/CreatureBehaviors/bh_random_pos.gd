class_name BHRandomPos extends BHCreature

@export var boundaries := Rect2(-100, -100, 200, 200)


func _process_physics_node(_delta: float) -> StateEnum:
	print_debug("called")
	var target := Vector2(randf_range(boundaries.position.x, boundaries.end.x), randf_range(boundaries.position.y, boundaries.end.y))
	pawn.navigation_agent.target_position = target
	return StateEnum.SUCCESS

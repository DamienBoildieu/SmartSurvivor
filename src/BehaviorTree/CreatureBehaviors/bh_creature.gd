class_name BHCreature extends BHNode


@export var pawn: Creature


func _setup(args: Dictionary) -> void:
	if pawn == null:
		pawn = args.get("pawn") as Creature
		if pawn == null:
			print_debug("No pawn defined")

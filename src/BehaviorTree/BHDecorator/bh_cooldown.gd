class_name BHCooldown extends BHDecorator


@export var cooldown := 1.0
var available := true
var timer: Timer


func _setup(args: Dictionary) -> void:
	super(args)


func _process_node(delta: float) -> StateEnum:
	if available:
		return child._process_node(delta)
		available = false
	else:
		return StateEnum.FAIL


func _process_physics_node(delta: float) -> StateEnum:
	if available:
		return child._process_physics_node(delta)
		available = false
	else:
		return StateEnum.FAIL

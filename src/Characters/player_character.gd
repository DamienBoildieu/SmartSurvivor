extends TopDownCharacter

class_name PlayerCharacter


func handle_inputs() -> void:
	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK
		return
	var direction_input: float = Input.get_axis("move_left", "move_right")
	if direction_input:
		velocity.x = direction_input
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	direction_input = Input.get_axis("move_up", "move_down")
	if direction_input:
		velocity.y = direction_input
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	if velocity.length() > 0:
		state = State.WALK
		velocity = velocity.normalized() * speed
	else:
		state = State.IDLE


func _physics_process(delta):
	handle_inputs()
	super(delta)

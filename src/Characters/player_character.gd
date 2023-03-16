extends "res://src/Characters/top_down_character.gd"

func _input(event):
	if event.is_action_pressed("attack"):
		state = State.ATTACK
		hit()

func _physics_process(_delta):	
	var direction_input: float = Input.get_axis("move_left", "move_right")
	if direction_input:
		velocity.x = direction_input * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	direction_input = Input.get_axis("move_up", "move_down")
	if direction_input:
		velocity.y = direction_input * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	if velocity.length() > 0:
		state = State.WALK
		velocity = velocity.normalized() * speed
	else:
		state = State.IDLE
		
	super(_delta)
	move_and_slide()

func _update_direction() -> void:
	var direction_input: float = Input.get_axis("move_left", "move_right")
	if direction_input < 0:
		direction = Direction.LEFT
	elif direction_input > 0:
		direction = Direction.RIGHT

	direction_input = Input.get_axis("move_up", "move_down")
	if direction_input < 0:
		direction = Direction.UP
	elif direction_input > 0:
		direction = Direction.DOWN

class_name PlaceState
extends CharacterState


func _process_physics_state(_delta: float) -> void:
	var direction_input: float = Input.get_axis("move_left", "move_right")
	if direction_input:
		character.velocity.x = direction_input
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.speed)

	direction_input = Input.get_axis("move_up", "move_down")
	if direction_input:
		character.velocity.y = direction_input
	else:
		character.velocity.y = move_toward(character.velocity.y, 0, character.speed)

	if character.velocity.length() > 0:
		character.state = TopDownCharacter.AnimationState.WALK
		character.velocity = character.velocity.normalized() * character.speed
	else:
		character.state = TopDownCharacter.AnimationState.IDLE


func _state_inputs(event: InputEvent) -> void:
	if event.is_action_pressed("build"):
		pass
	elif event.is_action("cancel"):
		pass

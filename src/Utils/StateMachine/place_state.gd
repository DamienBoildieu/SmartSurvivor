class_name PlaceState
extends CharacterState


func _enter_state(arguments := {}) -> void:
	character.place_area.update(arguments["recipe"] as Recipe)
	var offset := character.interaction_shape.position
	offset.y -= character.place_area.collision_shape.shape.size.y
	character.place_area.position = offset
	character.place_area.activate()


func _exit_state() -> Dictionary:
	character.place_area.deactivate()
	return super._exit_state()


func _process_physics_state(_delta: float) -> void:
	if Input.is_key_pressed(KEY_CTRL):
		return
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
	if event.is_action_pressed("move_build_up"):
		var offset := character.interaction_shape.position
		offset.y -= character.place_area.collision_shape.shape.size.y
		character.place_area.position = offset
	elif event.is_action_pressed("move_build_down"):
		var offset := character.interaction_shape.position
		offset.y += character.place_area.collision_shape.shape.size.y
		character.place_area.position = offset
	elif event.is_action_pressed("move_build_left"):
		var offset := character.interaction_shape.position
		offset.x -= character.place_area.collision_shape.shape.size.x
		character.place_area.position = offset
	elif event.is_action_pressed("move_build_right"):
		var offset := character.interaction_shape.position
		offset.x += character.place_area.collision_shape.shape.size.x
		character.place_area.position = offset
	elif event.is_action_pressed("interact"):
		character.place_area.build_scene()
	elif event.is_action_pressed("cancel"):
		character.cancel_build.emit()

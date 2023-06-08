class_name PlaceState
extends CharacterState


signal build(building: Node)
signal cancel()


var building: PackedScene


func _enter_state(arguments := {}) -> void:
	var recipe = arguments["recipe"] as Recipe
	var sprite := character.place_area.get_node("Sprite2D") as Sprite2D
	var collision_shape := character.place_area.get_node("CollisionShape2D") as CollisionShape2D
	sprite.texture = recipe.texture
	collision_shape.shape.size = recipe.texture.get_size()
	collision_shape.disabled = false
	building = recipe.building
	character.place_area.visible = true


func _exit_state() -> Dictionary:
	character.place_area.get_node("CollisionShape2D").disabled = true
	character.place_area.visible = false
	return super._exit_state()


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
		build.emit(building.instantiate())
	elif event.is_action("cancel"):
		print_debug("emit")
		cancel.emit()

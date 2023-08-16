class_name CharacterState
extends State


enum StateType {FREEROAM, PLACE, BUILD}


@export var state_type: StateType:
	get:
		return state_type
	set(new_value):
		state_type = new_value
		state_id = state_type


var character: TopDownCharacter


func _init_state(arguments := {}) -> void:
	var new_character := arguments.get("character") as TopDownCharacter
	if new_character == null:
		print_debug("Character not set")
	else:
		character = new_character
	super._init_state(arguments)

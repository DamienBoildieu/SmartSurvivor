class_name CharacterState
extends State

var character: TopDownCharacter


func _init_state(arguments := {}) -> void:
	var new_character := arguments.get("character") as TopDownCharacter
	if new_character == null:
		print_debug("Character is null")
	else:
		character = new_character
	super._init_state(arguments)

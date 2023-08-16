class_name StateMachine
extends State

@export var initial_state: State
@export var states: Array[State]
var states_dict: Dictionary
var current_state: State


func init_state(arguments := {}) -> void:
	states.push_back(initial_state)
	for state in states:
		state._init_state(arguments)
		states_dict[state.state_id] = state
	current_state = initial_state


func _process_state(delta: float) -> void:
	current_state._process_state(delta)


func _process_physics_state(delta: float) -> void:
	current_state._process_physics_state(delta)


func _state_inputs(event: InputEvent) -> void:
	current_state._state_inputs(event)


func travel(new_state: int, arguments:= {}) -> void:
	if current_state != null:
		arguments.merge(current_state._exit_state())
	current_state = states_dict[new_state]
	current_state._enter_state(arguments)

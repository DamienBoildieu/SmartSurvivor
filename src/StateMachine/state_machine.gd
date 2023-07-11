class_name StateMachine
extends Resource

@export var initial_state: State
@export var states: Array[State]


var current_state: State


func init_state_machine(arguments := {}) -> void:
	states.push_back(initial_state)
	for state in states:
		state._init_state(arguments)
	current_state = initial_state


func _process_state_machine(delta: float) -> void:
	current_state._process_state(delta)


func _process_physics_state_machine(delta: float) -> void:
	current_state._process_physics_state(delta)


func _state_machine_inputs(event: InputEvent) -> void:
	current_state._state_inputs(event)


func travel(new_state: State, arguments:= {}) -> void:
	if current_state != null:
		arguments.merge(current_state._exit_state())
	current_state = new_state
	current_state._enter_state(arguments)

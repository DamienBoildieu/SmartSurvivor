class_name State
extends Resource


func _init_state(_arguments := {}) -> void:
	pass


func _enter_state(_arguments := {}) -> void:
	pass


func _exit_state() -> Dictionary:
	return {}


func _process_state(_delta: float) -> void:
	pass


func _process_physics_state(_delta: float) -> void:
	pass


func _state_inputs(_event: InputEvent) -> void:
	pass

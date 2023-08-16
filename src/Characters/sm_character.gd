class_name SMCharacter extends CharacterBody2D


@export var state_machine: StateMachine


func _ready() -> void:
	state_machine.init_state({"character": self})


func _process(delta: float) -> void:
	state_machine._process_state(delta)


func _physics_process(delta: float) -> void:
	state_machine._process_physics_state(delta)
	_update_animation()
	move_and_slide()


func _input(event: InputEvent) -> void:
	state_machine._state_inputs(event)


func _update_animation() -> void:
	pass

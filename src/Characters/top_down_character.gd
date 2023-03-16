extends CharacterBody2D


enum State {IDLE, WALK, ATTACK, DIE}

@export var speed = 150.0


@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
var state = State.IDLE


func _physics_process(_delta):
	update_direction()
	move_and_slide()


func update_direction() -> void:
	var current: String = animation_state_machine.get_current_node()
	var parameter_name: String = "parameters/" + current + "/blend_position"
	if velocity != Vector2.ZERO:
		var direction: Vector2 = velocity.normalized()
		# y axis in bleding space is opposed to y axis in game space
		direction.y = - direction.y
		$AnimationTree.set(parameter_name, direction)


func _on_animation_finished() -> void:
	pass


func hit() -> void:
	pass

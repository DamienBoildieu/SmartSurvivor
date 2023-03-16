extends CharacterBody2D


enum State {IDLE, WALK, ATTACK, DIE}

const CharToAnim = {
	State.IDLE: "Idle",
	State.WALK: "Walk",
	State.ATTACK: "Attack",
	State.DIE: "Die"
}


@export var speed = 150.0


@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
var state = State.IDLE


func _physics_process(_delta):
	update_direction()
	move_and_slide()


func update_direction() -> void:
	var next_state: String = CharToAnim[state]
	animation_state_machine.travel(next_state)
	if velocity != Vector2.ZERO:
		var direction: Vector2 = velocity.normalized()
		# y axis in bleding space is opposed to y axis in game space
		direction.y = - direction.y
		var blending_param: String = "parameters/" + animation_state_machine.get_current_node() + "/blend_position"
		$AnimationTree.set(blending_param, direction)
		var state_path: PackedStringArray = animation_state_machine.get_travel_path()
		for current_state in state_path:
			blending_param = "parameters/" + current_state + "/blend_position" 
			$AnimationTree.set(blending_param, direction)
		blending_param = "parameters/" + next_state + "/blend_position" 
		$AnimationTree.set(blending_param, direction)

func _on_animation_finished() -> void:
	pass


func hit() -> void:
	pass

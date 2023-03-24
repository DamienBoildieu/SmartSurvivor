extends CharacterBody2D


enum State {IDLE, WALK, ATTACK, DIE}

const CharToAnim: Dictionary = {
	State.IDLE: "Idle",
	State.WALK: "Walk",
	State.ATTACK: "Attack",
	State.DIE: "Die"
}


@export var speed: float = 150.0
@export var health: float = 100.0
@export var energy: float = 100.0
@export var hungry: float = 100.0
@export var thirsty: float = 100.0


@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
var state: State = State.IDLE
var direction: Vector2 = Vector2(0., -1.)

func _physics_process(_delta):
	update_animation()
	move_and_slide()


func set_blending_position(param: String, blending_pos: Vector2) -> void:
	var blending_param: String = "parameters/" + param + "/blend_position"
	$AnimationTree.set(blending_param, blending_pos)


func apply_blending(next_state: String, blending_pos: Vector2) -> void:
	var current_state: String = animation_state_machine.get_current_node()
	set_blending_position(current_state, blending_pos)
	var state_path: PackedStringArray = animation_state_machine.get_travel_path()
	for st in state_path:
		set_blending_position(st, blending_pos)
	if next_state != current_state:
		set_blending_position(next_state, blending_pos)


func update_animation() -> void:
	var next_state: String = CharToAnim[state]
	if velocity != Vector2.ZERO:
		direction = velocity.normalized()
		# y axis in bleding space is opposed to y axis in game space
		direction.y = - direction.y
	apply_blending(next_state, direction)
	animation_state_machine.travel(next_state)

func perform_attack(target: Node) -> void:
	if target.has_method("take_damage"):
		target.take_damage()


func _on_attack_area_area_entered(area:Area2D):
	perform_attack(area)
	

func _on_attack_area_body_entered(body):
	perform_attack(body)

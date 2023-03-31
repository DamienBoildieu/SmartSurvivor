extends CharacterBody2D

class_name TopDownCharacter

enum State {IDLE, WALK, ATTACK, DIE}


const CharToAnim: Dictionary = {
	State.IDLE: "Idle",
	State.WALK: "Walk",
	State.ATTACK: "Attack",
	State.DIE: "Die"
}


signal health_updated(new_health: int)
signal energy_updated(new_energy: int)
signal hungry_updated(new_hungry: int)
signal thirsty_updated(new_thirsty: int)
signal die


@export var max_health: int = 10
@export var max_energy: int = 5
@export var max_hungry: int = 5
@export var max_thirsty: int = 5
@export var max_speed: float = 150.0



@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
var health: int = max_health
var energy: int = max_energy
var hungry: int = max_hungry
var thirsty: int = max_thirsty
var speed: float = max_speed
var state: State = State.IDLE
var direction: Vector2 = Vector2(0., -1.)


func _ready():
	$NeedsTimer.start()


func _physics_process(_delta):
	if is_dead():
		state = State.DIE
		die.emit()
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


func update_thirsty() -> void:
	if thirsty > 0:
		thirsty -= 1
		thirsty_updated.emit(thirsty)
	else:
		take_damage(1)


func update_hungry() -> void:
	if hungry > 0:
		hungry -= 1
		hungry_updated.emit(hungry)
	else:
		take_damage(1)


func update_energy() -> void:
	if energy > 0:
		energy -= 1
		energy_updated.emit(energy)
	else:
		take_damage(1)


func take_damage(damage: int) -> void:
	health -= damage
	health_updated.emit(health)


func perform_attack(target: Node) -> void:
	if target.has_method("take_damage"):
		target.take_damage()


func _on_attack_area_area_entered(area:Area2D):
	perform_attack(area)
	

func _on_attack_area_body_entered(body):
	perform_attack(body)


func _on_needs_timer_timeout():
	update_thirsty()
	update_hungry()
	update_energy()

func is_dead() -> bool:
	return health <= 0

class_name TopDownCharacter
extends CharacterBody2D


enum State {IDLE, WALK, ATTACK, DIE}


const CharToAnim: Dictionary = {
	State.IDLE: "Idle",
	State.WALK: "Walk",
	State.ATTACK: "Attack",
	State.DIE: "Die"
}


signal item_picked(item: Item)


@export var max_speed: float = 150.0

var speed: float = max_speed
var direction: Vector2 = Vector2(0., -1.)
var state: State = State.IDLE
@onready
var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var health: Health = $Health
@onready var energy: Need = $Energy
@onready var water: Need = $Water
@onready var food: Need = $Food
@onready var inventory: Inventory = $Inventory
@onready var animation_tree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var interaction_shape = $InteractionArea/CollisionShape2D


func _ready():
	# Not working by setting it to true in the editor
	$Sprite2D/AttackArea/CollisionShape2D.disabled = true


func _physics_process(_delta):
	update_animation()
	move_and_slide()


func set_blending_position(param: String, blending_pos: Vector2) -> void:
	var blending_param: String = "parameters/" + param + "/blend_position"
	animation_tree.set(blending_param, blending_pos)


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
	if target.has_node("Health"):
		target.get_node("Health").take_damage(1)


func _on_attack_area_area_entered(area:Area2D):
	perform_attack(area)


func _on_attack_area_body_entered(body):
	perform_attack(body)


func _on_water_lack_need():
	health.take_damage(1)


func _on_energy_lack_need():
	health.take_damage(1)


func _on_food_lack_need():
	health.take_damage(1)


func _on_health_die():
	return
	state = State.DIE
	velocity = Vector2.ZERO


func _on_interaction_area_area_entered(area):
	if area is PickableItem:
		inventory.add_item(area.item, area.quantity)
		item_picked.emit(area)


func _on_inventory_drop_item(item, amount):
	var drop_position: Vector2 = interaction_shape.global_position
	var drop_area := Vector2.ZERO
	if velocity != Vector2.ZERO:
		var curr_direction = velocity.normalized()
		drop_position -= curr_direction * interaction_shape.shape.size * 2
	else:
		drop_area = interaction_shape.shape.size * 2
	GlobalDropItem.drop_item(item, amount, drop_position, drop_area)

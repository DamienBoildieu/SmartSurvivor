class_name TopDownCharacter
extends CharacterBody2D


enum AnimationState {IDLE, WALK, ATTACK, DIE}


const AnimationEnumMap: Dictionary = {
	AnimationState.IDLE: "Idle",
	AnimationState.WALK: "Walk",
	AnimationState.ATTACK: "Attack",
	AnimationState.DIE: "Die"
}


signal item_picked(item: Item)


@export var max_speed: float = 150.0
@export var work_force: int = 1
@export var inventory: Inventory
@export var recipes: RecipeBook
@export var state_machine: StateMachine


const building_site: PackedScene = preload("res://src/World/building_site.tscn")
var speed: float = max_speed
var direction: Vector2 = Vector2(0., -1.)
var state: AnimationState = AnimationState.IDLE
@onready
var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var health: Health = $Health
@onready var energy: Need = $Energy
@onready var water: Need = $Water
@onready var food: Need = $Food
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var body_shape: CollisionShape2D = $BodyArea/CollisionShape2D
@onready var place_area: PlaceArea = $PlaceArea
@onready var attack_audio: AudioStreamPlayer2D = $AttackArea/AudioStreamPlayer2D
@onready var interaction: Interaction = $Interaction


func _ready() -> void:
	place_area.build.connect(build)
	place_area.cancel.connect(cancel_place)
	state_machine.init_state_machine({"character": self})


func _process(delta):
	state_machine._process_state_machine(delta)


func _physics_process(delta) -> void:
	state_machine._process_physics_state_machine(delta)
	update_animation()
	move_and_slide()


func _input(event):
	state_machine._state_machine_inputs(event)


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
	var next_state: String = AnimationEnumMap[state]
	if velocity != Vector2.ZERO:
		direction = velocity.normalized()
		# y axis in bleding space is opposed to y axis in game space
		direction.y = - direction.y
	apply_blending(next_state, direction)

	animation_state_machine.travel(next_state)


func perform_attack(target: Node) -> void:
	if target.has_node("Health"):
		target.get_node("Health").take_damage(1)
		attack_audio.play()


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
	state = AnimationState.DIE


func _on_use_item(item: UsableItem, amount: int = 1) -> void:
	use_item(item, amount)
	inventory.remove_items({item: amount})


func _on_drop_item(item: Item, amount: int) -> void:
	drop_item(item, amount)
	inventory.remove_items({item: amount})


func _on_build_place(recipe: Recipe) -> void:
	state_machine.travel(state_machine.states[0], {"recipe": recipe})


func use_item(item: UsableItem, amount: int) -> void:
	for ii in amount:
		item._use_on(self)


func drop_item(item: Item, amount: int) -> void:
	var drop_position: Vector2 = body_shape.global_position
	var drop_area := Vector2.ZERO
	if velocity != Vector2.ZERO:
		var curr_direction = velocity.normalized()
		drop_position -= curr_direction * body_shape.shape.size * 2
	else:
		drop_area = body_shape.shape.size * 2
	GlobalDropItem.drop_item(item, amount, drop_position, drop_area)


func build(recipe: Recipe) -> void:
	if inventory.has_all(recipe.requires):
		inventory.remove_items(recipe.requires)
		var instantiated_bs := building_site.instantiate() as BuildingSite
		print(instantiated_bs)
		if building_site == null:
			print_debug("Error while instantiating building site")
			return
		instantiated_bs.recipe = recipe
		instantiated_bs.position = place_area.global_position
		owner.add_building_site(instantiated_bs)
		state_machine.travel(state_machine.states[1], {"building_site": instantiated_bs})


func stop_build() -> void:
	state_machine.travel(state_machine.states[2])


func resume_build(new_bs: BuildingSite) -> void:
	state_machine.travel(state_machine.states[1], {"building_site": new_bs})


func cancel_place() -> void:
	state_machine.travel(state_machine.states[2])


func _on_body_area_area_entered(area):
	if area is PickableItem:
		inventory.add_item(area.item, area.quantity)
		item_picked.emit(area)

extends StaticBody2D


signal cut(nb_wood)
signal die(Tree)


@export var max_cut_days: int = 5
@export var max_wood: int = 5


var days_before_growth: int = 5
var is_cutted = false
var remaining_days: int = max_cut_days
@onready var sprite: TreeSprite = $TreeSprite
@onready var animation_player = $AnimationPlayer
@onready var health: Health = $Health
@onready var collision_shape: CollisionShape2D = $TreeCollisionShape
@onready var wood = preload("res://src/Items/wood.tres")


func _ready():
	sprite.load_tree()


func cut_tree() -> void:
	if not is_cutted:
		var nb_wood = randi()%max_wood+1
		GlobalDropItem.drop_item(wood, nb_wood, collision_shape.global_position, collision_shape.shape.size)
		cut.emit(nb_wood)
		sprite.load_trunk()
		is_cutted = true


func grow() -> void:
	health.add_health(health.max_health)
	sprite.load_tree()
	is_cutted = false


func _on_health_die():
	die.emit(self)
	self.queue_free()


func _on_health_hit():
	animation_player.play("hit")
	if health.health < 3:
		cut_tree()

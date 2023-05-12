extends StaticBody2D


signal cut(nb_wood)


@export var max_cut_days: int = 5
@export var max_wood: int = 5


var days_before_growth: int = 5
var is_cutted = false
var remaining_days: int = max_cut_days
@onready var sprite: TreeSprite = $TreeSprite
@onready var animation_player = $AnimationPlayer
@onready var health: Health = $Health
@onready var collision_shape: CollisionShape2D = $TreeCollisionShape
# @onready var drop_item: DropItem = $DropItem
@onready var wood = preload("res://src/Items/wood.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.load_tree()


func cut_tree() -> void:
	var nb_wood = randi()%max_wood
	GlobalDropItem.drop_item(wood, nb_wood, position, collision_shape.shape.size)
	# drop_item.drop_item(wood, nb_wood, position, collision_shape.shape.size)
	# ressources.item = item
	# var spawn_translation: Vector2 = Vector2((randi()%3)-1, (randi()%3)-1)
	# if spawn_translation == Vector2.ZERO:
	#	spawn_translation.y -= 1
	# ressources.position = position + spawn_translation * collision_shape.shape.size
	# owner.call_deferred("add_child", ressources)
	cut.emit(nb_wood)
	sprite.load_trunk()


func grow() -> void:
	health.add_health(health.max_health)
	sprite.load_tree()


func _on_health_die():
	cut_tree()


func _on_health_hit():
	animation_player.play("hit")

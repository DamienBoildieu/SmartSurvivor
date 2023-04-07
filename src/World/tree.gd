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


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.load_tree()


func cut_tree() -> void:
	var nb_wood = randi()%max_wood
	cut.emit(nb_wood)
	sprite.load_trunk()


func grow() -> void:
	health.add_health(health.max_health)
	sprite.load_tree()


func _on_health_die():
	cut_tree()


func _on_health_hit():
	animation_player.play("hit")

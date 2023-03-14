extends StaticBody2D


signal cut(nb_wood)


@export_category("Characterisctics")
@export var MAX_CUT_DAY = 5
@export var MAX_HEALTH = 100
@export var health = MAX_HEALTH


var days_before_growth = 5
var is_cutted = false
var remaining_days: int = MAX_CUT_DAY
@onready var sprite = $TreeSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.load_tree()

func _on_hit(damage: int) -> void:
	health -= damage
	if health <= 0:
		cut_tree()

func cut_tree() -> void:
	var nb_wood = randi()%5
	cut.emit(nb_wood)
	sprite.load_trunk()

func grow() -> void:
	health = MAX_HEALTH
	sprite.load_tree()

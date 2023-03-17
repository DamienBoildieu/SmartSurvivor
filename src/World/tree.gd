extends StaticBody2D


signal cut(nb_wood)


@export_category("Characterisctics")
@export var MAX_CUT_DAY = 5
@export var MAX_HEALTH = 5
@export var health = MAX_HEALTH


var days_before_growth = 5
var is_cutted = false
var remaining_days: int = MAX_CUT_DAY
@onready var sprite = $TreeSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.load_tree()

func take_damage(damage: int = 1) -> void:
	if health > 0 and $DamageTimer.can_take_damage:
		$DamageTimer.start_timer() 
		health -= damage
		$AnimationPlayer.play("hit")
		if health <= 0:
			cut_tree()

func cut_tree() -> void:
	var nb_wood = randi()%5
	cut.emit(nb_wood)
	sprite.load_trunk()

func grow() -> void:
	health = MAX_HEALTH
	sprite.load_tree()

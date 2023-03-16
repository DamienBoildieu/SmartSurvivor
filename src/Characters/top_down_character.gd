extends CharacterBody2D


enum Direction {UP, DOWN, LEFT, RIGHT}
enum State {IDLE, WALK, ATTACK}

@export var speed = 100.0


var direction = Direction.DOWN
var state = State.IDLE
@onready var sprite = $AnimatedSprite2D


func _physics_process(_delta):
	_update_direction()
	play_animation()
	
func get_animation_name() -> String:
	var animation_name: String
	match state:
		State.IDLE:
			animation_name = "stand_"
		State.WALK:
			animation_name = "walk_"
		State.ATTACK:
			animation_name = "attack_"

	match direction:
		Direction.UP:
			animation_name += "up"
		Direction.DOWN:
			animation_name += "down"
		Direction.LEFT, Direction.RIGHT:
			animation_name += "side"
			sprite.flip_h = direction == Direction.LEFT
	return animation_name

func play_animation() -> void:
	var animation_name: String = get_animation_name()
	sprite.play(animation_name)

func _on_animation_finished() -> void:
	pass

func _update_direction() -> void:
	pass

func hit() -> void:
	pass

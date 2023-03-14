extends CharacterBody2D


enum Direction {UP, DOWN, LEFT, RIGHT}


@export var speed = 100.0


var direction: Direction = Direction.DOWN
@onready var sprite = $AnimatedSprite2D


func _physics_process(_delta):
	update_direction()
	play_animation()
	hit()
	move_and_slide()
	
func get_animation_name(move_vector: Vector2) -> String:
	var animation_name: String
	if move_vector.length() > 0:
		animation_name = "walk_"
	else:
		animation_name = "stand_"

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
	var animation_name: String = get_animation_name(velocity)
	sprite.play(animation_name)	

func update_direction() -> void:
	pass

func hit() -> void:
	pass

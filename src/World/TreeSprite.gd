extends Sprite2D

class_name TreeSprite

@export_category("Sprites")
@export_file var tree_sprite: String
@export_file var trunk_sprite: String


# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load(tree_sprite))

func load_trunk() -> void:
	set_texture(load(trunk_sprite))
	offset.y = 17

func load_tree() -> void:
	set_texture(load(tree_sprite))
	offset.y = 0

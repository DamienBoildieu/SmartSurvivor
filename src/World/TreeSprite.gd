extends Sprite2D

@export_category("Sprites")
@export var tree_sprite: String
@export var trunk_sprite: String


# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load(tree_sprite))

func load_trunk() -> void:
	set_texture(load(trunk_sprite))
	offset.y = 17

func load_tree() -> void:
	set_texture(load(tree_sprite))
	offset.y = 0

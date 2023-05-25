class_name RecipePanel
extends VBoxContainer


signal build(recipe: Recipe)


@export var recipe: Recipe:
	get:
		return recipe
	set(new_recipe):
		recipe = new_recipe
		if is_ready:
			update_recipe()


@onready var name_label: RichTextLabel = $NameLabel
@onready var description_label: RichTextLabel = $DescriptionLabel
var is_ready: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	is_ready = true
	update_recipe()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_recipe() -> void:
	if recipe != null:
		update_name_label()
		update_description()


func update_description() -> void:
	description_label.text = recipe.description


func update_name_label() -> void:
	name_label.clear()
	name_label.add_image(recipe.texture)
	name_label.add_text(recipe.name)


func update_require_list() -> void:
	pass


func update_build_button() -> void:
	pass


func _on_build_button_pressed():
	pass # Replace with function body.

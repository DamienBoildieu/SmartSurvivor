class_name RecipeIcon
extends PanelContainer


signal recipe_clicked(item: RecipeIcon)


@export var recipe: Recipe:
	get:
		return recipe
	set(new_recipe):
		recipe = new_recipe
		if is_ready:
			update_recipe()


var sprite: TextureRect
var label: Label
var is_ready: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $HBoxContainer/TextureRect
	label = $HBoxContainer/Label
	is_ready = true
	update_recipe()


func update_recipe():
	sprite.texture = recipe.texture
	tooltip_text = recipe.description
	label.text = recipe.name


func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			recipe_clicked.emit(self)

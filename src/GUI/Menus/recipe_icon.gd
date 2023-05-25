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

@export var buildable_color: Color = Color.WHITE
@export var unbuildable_color: Color = Color.DIM_GRAY


@onready var rich_label: RichTextLabel = $RichTextLabel
var is_ready: bool = false

var can_be_build: bool = false:
	get:
		return can_be_build
	set(new_value):
		can_be_build = new_value
		if is_ready:
			update_recipe()


# Called when the node enters the scene tree for the first time.
func _ready():
	is_ready = true
	update_recipe()


func update_recipe():
	rich_label.clear()
	if can_be_build:
		rich_label.push_color(buildable_color)
	else:
		rich_label.push_color(unbuildable_color)
	rich_label.add_image(recipe.texture)
	rich_label.add_text(recipe.name)
	rich_label.pop()
	tooltip_text = recipe.description


func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			recipe_clicked.emit(self)

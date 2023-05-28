class_name RecipePanel
extends VBoxContainer


signal build(recipe: Recipe)


@export var enough_color: Color = Color.GREEN
@export var missing_color: Color = Color.RED
@export var recipe: Recipe:
	get:
		return recipe
	set(new_recipe):
		recipe = new_recipe
		if is_ready:
			update_recipe()

@export var inventory: Inventory:
	get:
		return inventory
	set(new_inventory):
		inventory = new_inventory
		if is_ready:
			update_recipe()

@onready var name_label: RichTextLabel = $NameLabel
@onready var description_label: RichTextLabel = $DescriptionLabel
@onready var require_list: RichTextLabel = $RequireLabel
@onready var construction_time_label: Label = $ConstructionTimeLabel
var is_ready: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_ready = true
	update_recipe()


func update_recipe() -> void:
	if recipe != null:
		update_name_label()
		update_description()
		update_require_list()
		update_construction_time_label()


func update_description() -> void:
	description_label.text = recipe.description


func update_name_label() -> void:
	name_label.clear()
	name_label.add_image(recipe.texture)
	name_label.add_text(recipe.name)


func update_require_list() -> void:
	require_list.clear()
	var text_color: Color
	var idx = 0
	for item in recipe.requires:
		var in_inventory = inventory.items.get(item, 0)
		var required_amount = recipe.requires[item]
		if in_inventory < required_amount:
			text_color = missing_color
		else:
			text_color = enough_color
		require_list.push_color(text_color)
		require_list.add_text("%d/%d" % [in_inventory, required_amount])
		require_list.pop()
		require_list.add_image(item.texture)
		if idx < (recipe.requires.size()-1):
			require_list.newline()
		idx += 1


func update_construction_time_label() -> void:
	construction_time_label.text = "Construction time: %.1f" % recipe.construction_time


func _on_build_button_pressed():
	pass # Replace with function body.

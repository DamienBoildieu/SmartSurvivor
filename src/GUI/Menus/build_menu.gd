class_name BuildMenu
extends HSplitContainer


@onready var grid: GridContainer = $GridContainer
@onready var recipe_panel: RecipePanel = $RecipePanel


var recipe_icon_template: PackedScene = preload("res://src/GUI/Menus/recipe_icon.tscn")
var inventory: Inventory
var recipes: RecipeBook


func setup_menu(new_recipes: RecipeBook, new_inventory: Inventory) -> void:
	setup_recipes(new_recipes)
	setup_inventory(new_inventory)


func setup_recipes(new_recipes: RecipeBook) -> void:
	if new_recipes != recipes:
		recipes = new_recipes
	#inventory.inventory_changed.connect(_on_inventory_changed)
	refresh_recipes()


func setup_inventory(new_inventory: Inventory) -> void:
	if new_inventory != inventory:
		if inventory != null:
			inventory.inventory_changed.disconnect(_on_inventory_changed)
		inventory = new_inventory
		recipe_panel.inventory = inventory
		inventory.inventory_changed.connect(_on_inventory_changed)
	refresh_recipes()


func refresh_recipes() -> void:
	for c_node in grid.get_children():
		c_node.queue_free()
	
	for recipe in recipes.recipes:
		var icon := recipe_icon_template.instantiate() as RecipeIcon
		icon.recipe = recipe
		icon.can_be_build = inventory == null or GlobalBuild.can_be_build(inventory, recipe)
		icon.recipe_clicked.connect(_on_recipe_clicked)
		grid.add_child(icon)


func _on_recipe_clicked(recipe: RecipeIcon) -> void:
	recipe_panel.recipe = recipe.recipe
	recipe_panel.show()


func _on_inventory_changed() -> void:
	refresh_recipes()
	recipe_panel.hide()


func _on_visibility_changed():
	if recipe_panel != null:
		recipe_panel.hide()

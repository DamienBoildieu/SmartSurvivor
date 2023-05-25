class_name Build
extends Node


signal builded(building: Node)


func can_be_build(inventory: Inventory, recipe: Recipe) -> bool:
	for item in recipe.requires:
		if inventory.items.get(item, 0) < recipe.requires[item]:
			return false
	return true


func build(inventory: Inventory, recipe: Recipe, position: Vector2) -> void:
	var building = recipe.building.instantiate()
	for item in recipe.requires:
		inventory.drop(item, recipe.requires[item])
	building.position = position
	builded.emit(building)

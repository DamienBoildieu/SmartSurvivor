class_name Build
extends Node


signal builded(building: Node)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func can_be_build(inventory: Inventory, recipe: Recipe) -> bool:
	for item in recipe.requires:
		if inventory.items.get(item, 0) < recipe[item]:
			return false
	return true


func build(inventory: Inventory, recipe: Recipe, position: Vector2) -> void:
	var building = recipe.building.instantiate()
	building.position = position
	builded.emit(building)

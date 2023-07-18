class_name FoodItem
extends UsableItem

@export var food_value := 5


func _use_on(other: Node2D) -> void:
	if "food" in other:
		other.food.improve_need(food_value)

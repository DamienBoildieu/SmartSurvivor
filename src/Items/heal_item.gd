class_name HealItem
extends UsableItem


@export var heal_value := 5


func _use_on(other: Node2D) -> void:
	if "health" in other:
		other.health.add_health(heal_value)

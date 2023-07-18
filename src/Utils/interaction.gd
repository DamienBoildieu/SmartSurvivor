class_name Interaction
extends Area2D


var interactable_objects: Array[Interactable]
var interaction_idx: int = -1


func _on_area_entered(area: Area2D) -> void:
	check_and_add(area)


func _on_area_exited(area: Area2D) -> void:
	check_and_remove(area)


func interaction_idx_cycle() -> void:
	if interactable_objects.size() > 0:
		interactable_objects[interaction_idx]._unselect()
		interaction_idx = (interaction_idx + 1) % interactable_objects.size()
		interactable_objects[interaction_idx]._select()


func interact() -> void:
	if len(interactable_objects) > 0:
		interactable_objects[interaction_idx].interact_with(owner)


func _on_body_entered(body: Node2D) -> void:
	check_and_add(body)


func _on_body_exited(body: Node2D) -> void:
	check_and_remove(body)


func check_and_add(other: Node2D) -> void:
	if "interactable" in other:
		print(other)
		interactable_objects.append(other.interactable)
		if interaction_idx == -1:
			interaction_idx = 0
			interactable_objects[interaction_idx]._select()


func check_and_remove(other: Node2D) -> void:
	if "interactable" in other:
		var idx := interactable_objects.find(other.interactable)
		if idx != -1:
			if interaction_idx == idx:
				interactable_objects[interaction_idx]._unselect()
			interactable_objects.remove_at(idx)
		if interactable_objects.size() == 0:
			interaction_idx = -1
		elif interaction_idx >= idx:
			interaction_idx -= 1

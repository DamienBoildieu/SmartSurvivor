class_name Interaction
extends Area2D


signal current_interaction_changed(target: Node2D)


var interactable_objects: Array[Node2D]
var interaction_idx: int = -1


func _on_area_entered(area: Area2D) -> void:
	check_and_add(area)


func _on_area_exited(area: Area2D) -> void:
	check_and_remove(area)


func interaction_idx_cycle() -> void:
	interaction_idx += 1 % interactable_objects.size()
	current_interaction_changed.emit(interactable_objects[interaction_idx])


func interact() -> void:
	if len(interactable_objects) > 0:
		interactable_objects[interaction_idx].interact_with(owner)


func _on_body_entered(body: Node2D) -> void:
	check_and_add(body)


func _on_body_exited(body: Node2D) -> void:
	check_and_remove(body)


func check_and_add(other: Node2D) -> void:
	if other.has_method("interact_with"):
		print(other)
		interactable_objects.append(other)
		if interaction_idx == -1:
			interaction_idx = 0


func check_and_remove(other: Node2D) -> void:
	var idx := interactable_objects.find(other)
	if idx != -1:
		interactable_objects.remove_at(idx)
	if interactable_objects.size() == 0:
		interaction_idx = -1
	elif interaction_idx >= idx:
		interaction_idx -= 1

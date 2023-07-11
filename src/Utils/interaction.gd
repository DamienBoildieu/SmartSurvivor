class_name Interaction
extends Area2D


signal current_interaction_changed(target: Node)


var interactable_objects: Array[Node]
var interaction_idx: int = -1


func _on_area_entered(area: Area2D) -> void:
	var interaction := area.get_node("Interaction") as Node
	if interaction != null:
		interactable_objects.append(area)
		if interaction_idx == -1:
			interaction_idx = 0


func _on_area_exited(area: Area2D) -> void:
	var idx := interactable_objects.find(area)
	if idx != -1:
		interactable_objects.remove_at(idx)
	if interactable_objects.size() == 0:
		interaction_idx = -1
	elif interaction_idx >= idx:
		interaction_idx -= 1


func interaction_idx_cycle() -> void:
	interaction_idx += 1 % interactable_objects.size()
	current_interaction_changed.emit(interactable_objects[interaction_idx])


func interact() -> void:
	interactable_objects[interaction_idx].interact_with(owner)

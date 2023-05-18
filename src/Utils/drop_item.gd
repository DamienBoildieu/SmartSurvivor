class_name DropItem
extends GenericPool


signal spawn(item: PickableItem)


func drop_item(item: Item, quantity: int, position: Vector2, size: Vector2 = Vector2.ZERO) -> void:
	var ressources : PickableItem = get_object()
	ressources.item = item
	ressources.quantity = quantity
	ressources.position = _get_position(position, size)
	spawn.emit(ressources)


func request_move(item: PickableItem, position: Vector2, size := Vector2.ZERO) -> void:
	item.position = _get_position(position, size)
	spawn.emit(item)


func _get_position(position: Vector2, size := Vector2.ZERO) -> Vector2:
	if size != Vector2.ZERO:
		var spawn_translation := Vector2((randi()%3)-1, (randi()%3)-1)
		if spawn_translation == Vector2.ZERO:
			spawn_translation.y -= 1
		position += spawn_translation * size
	return position

class_name DropItem
extends GenericPool


signal spawn(item: PickableItem)


# var pickable_item = preload("res://src/Items/pickable_item.tscn")
# @onready var pool: GenericPool = $Pool


func drop_item(item: Item, quantity: int, position: Vector2, size: Vector2 = Vector2.ZERO) -> void:
	var ressources : PickableItem = get_object()
	ressources.item = item
	ressources.quantity = quantity
	ressources.position = position
	if size != Vector2.ZERO:
		var spawn_translation := Vector2((randi()%3)-1, (randi()%3)-1)
		print_debug(spawn_translation)
		if spawn_translation == Vector2.ZERO:
			spawn_translation.y -= 1
		ressources.position += spawn_translation * size
	spawn.emit(ressources)

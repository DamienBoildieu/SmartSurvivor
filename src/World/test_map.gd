class_name TestMap
extends TileMap


@onready var canvas: CanvasLayer = $CanvasLayer
@onready var gui: GUI = $CanvasLayer/GUI
@onready var player: TopDownCharacter = $PlayerCharacter
@onready var pick_item_anim: PackedScene = preload("res://src/GUI/pick_item_anim.tscn")
@onready var inventory_menu: InventoryMenu = $CanvasLayer/InventoryMenu


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDropItem.spawn.connect(_on_spawn)
	# for generator in get_tree().get_nodes_in_group("RessourceGenerator"):
	# 	generator.get_node("DropItem").spawn.connect(_on_spawn)
	gui.health_bar.max_value = player.health.max_health
	gui.energy_bar.max_value = player.energy.max_need
	gui.food_bar.max_value = player.food.max_need
	gui.water_bar.max_value = player.water.max_need
	inventory_menu.visible = false
	inventory_menu.setup_inventory(player.inventory)


func _on_spawn(item: PickableItem) -> void:
	call_deferred("add_child", item)


func _input(event):
	if event.is_action_pressed("inventory"):
		inventory_menu.visible = !inventory_menu.visible


func play_pick_anim(anim: PickItemAnim) -> void:
	anim.anim_finished.connect(_on_pick_anim_finished)
	canvas.add_child(anim)
	anim.play_anim()


func _on_pick_anim_finished(anim: PickItemAnim) -> void:
	anim.anim_finished.disconnect(_on_pick_anim_finished)
	canvas.remove_child(anim)
	GlobalItemAnimPool.add_object(anim)


func _on_player_character_item_picked(item: PickableItem):
	var pick_anim : PickItemAnim = GlobalItemAnimPool.get_object()
	var item_pos: Vector2 = item.position
	item_pos -= Vector2(16, 32)
	var screen_coord = get_viewport_transform() * (get_global_transform() * item_pos)
	pick_anim.position = screen_coord
	pick_anim.item = item
	call_deferred("play_pick_anim", pick_anim)
	remove_child(item)
	GlobalDropItem.add_object(item)

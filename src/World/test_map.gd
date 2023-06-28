class_name TestMap
extends TileMap


@onready var canvas: CanvasLayer = $CanvasLayer
@onready var gui: GUI = $CanvasLayer/GUI
@onready var player: TopDownCharacter = $TopDownCharacter
@onready var pick_item_anim: PackedScene = preload("res://src/GUI/pick_item_anim.tscn")
@onready var menus: MenuPanel= $CanvasLayer/MenuPanel


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDropItem.spawn.connect(_on_spawn)
	gui.setup_character(player)
	# for generator in get_tree().get_nodes_in_group("RessourceGenerator"):
	# 	generator.get_node("DropItem").spawn.connect(_on_spawn)
	menus.visible = false
	menus.setup_menus(player)


func _on_spawn(item: PickableItem) -> void:
	call_deferred("add_child", item)


func spawn_item(item: PickableItem) -> void:
	add_child(item)


func play_pick_anim(anim: PickItemAnim) -> void:
	anim.anim_finished.connect(_on_pick_anim_finished)
	anim.position = -player.sprite.get_rect().size/2
	anim.position.x /= 2
	player.add_child(anim)
	anim.play_anim()


func _on_pick_anim_finished(anim: PickItemAnim) -> void:
	anim.anim_finished.disconnect(_on_pick_anim_finished)
	player.remove_child(anim)
	GlobalItemAnimPool.add_object(anim)


func _on_player_item_picked(item: PickableItem):
	var pick_anim : PickItemAnim = GlobalItemAnimPool.get_object()
	pick_anim.item = item
	pick_anim.scale = item.scale
	call_deferred("play_pick_anim", pick_anim)
	remove_child(item)
	GlobalDropItem.add_object(item)
	

func add_building_site(building_site: BuildingSite) -> void:
	add_child(building_site)
	building_site.building_complete.connect(_on_building_complete)


func _on_building_complete(building_site: BuildingSite) -> void:
	var instantiated_building := building_site.recipe.building.instantiate()
	instantiated_building.position = building_site.global_position
	remove_child(building_site)
	building_site.queue_free()
	add_child(instantiated_building)

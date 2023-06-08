class_name MenuPanel
extends TabContainer


@onready var inventory_menu: InventoryMenu = $Inventory
@onready var build_menu: BuildMenu = $Build


var name_to_idx: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	name_to_idx["inventory"] = get_tab_idx_from_control(inventory_menu)
	name_to_idx["build"] = get_tab_idx_from_control(build_menu)
	build_menu.recipe_panel.build.connect(_on_build)


func setup_menus(player: TopDownCharacter) -> void:
	inventory_menu.setup_inventory(player.inventory)
	build_menu.setup_menu(player)


func _input(event):
	var menu_name: String = ""
	if event.is_action_pressed("inventory"):
		menu_name = "inventory"
	elif event.is_action_pressed("build"):
		menu_name = "build"
	if menu_name != "":
		if self.visible and current_tab == name_to_idx[menu_name]:
			self.visible = false
		else:
			if not self.visible:
				self.visible = true
			current_tab = name_to_idx[menu_name]


func _on_build(_build) -> void:
	self.visible = false

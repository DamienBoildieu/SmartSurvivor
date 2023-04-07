extends TileMap


@onready var gui: GUI = $CanvasLayer/GUI
@onready var player: TopDownCharacter = $PlayerCharacter


# Called when the node enters the scene tree for the first time.
func _ready():
	gui.health_bar.max_value = player.health.max_health
	gui.energy_bar.max_value = player.get_node("Energy").max_need
	gui.food_bar.max_value = player.get_node("Food").max_need
	gui.water_bar.max_value = player.get_node("Water").max_need

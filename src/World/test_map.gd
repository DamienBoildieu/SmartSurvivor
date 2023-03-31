extends TileMap


@onready var gui: GUI = $CanvasLayer/GUI
@onready var player: TopDownCharacter = $PlayerCharacter


# Called when the node enters the scene tree for the first time.
func _ready():
	gui.health_bar.max_value = player.max_health
	gui.energy_bar.max_value = player.max_energy
	gui.food_bar.max_value = player.max_hungry
	gui.water_bar.max_value = player.max_thirsty


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

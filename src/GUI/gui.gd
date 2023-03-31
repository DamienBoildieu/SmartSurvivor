extends MarginContainer

class_name GUI

@onready var health_bar: AnimatedBar = $HBoxContainer/HealthBar
@onready var energy_bar: AnimatedBar = $HBoxContainer/VBoxContainer/EnergyBar
@onready var water_bar: AnimatedBar = $HBoxContainer/VBoxContainer/WaterBar
@onready var food_bar: AnimatedBar = $HBoxContainer/VBoxContainer/FoodBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_character_thirsty_updated(new_thirsty):
	water_bar.animate(new_thirsty)


func _on_player_character_hungry_updated(new_hungry):
	food_bar.animate(new_hungry)


func _on_player_character_energy_updated(new_energy):
	energy_bar.animate(new_energy)


func _on_player_character_health_updated(new_health):
	health_bar.animate(new_health)

class_name GUI
extends MarginContainer


@onready var health_bar: AnimatedBar = $HBoxContainer/HealthBar
@onready var energy_bar: AnimatedBar = $HBoxContainer/VBoxContainer/EnergyBar
@onready var water_bar: AnimatedBar = $HBoxContainer/VBoxContainer/WaterBar
@onready var food_bar: AnimatedBar = $HBoxContainer/VBoxContainer/FoodBar


func setup_character(player_character: TopDownCharacter) -> void:
	health_bar.max_value = player_character.health.max_health
	health_bar.value = player_character.health.health
	player_character.health.health_updated.connect(health_bar.animate)
	
	energy_bar.max_value = player_character.energy.max_need
	energy_bar.value = player_character.energy.need_value
	player_character.energy.need_updated.connect(energy_bar.animate)
	
	water_bar.max_value = player_character.water.max_need
	water_bar.value = player_character.water.need_value
	player_character.water.need_updated.connect(water_bar.animate)
	
	food_bar.max_value = player_character.food.max_need
	food_bar.value = player_character.food.need_value
	player_character.food.need_updated.connect(food_bar.animate)
	

func _on_water_need_updated(new_value):
	water_bar.animate(new_value)


func _on_food_need_updated(new_value):
	food_bar.animate(new_value)


func _on_energy_need_updated(new_value):
	energy_bar.animate(new_value)


func _on_health_health_updated(new_health):
	health_bar.animate(new_health)

extends MarginContainer

class_name GUI

@onready var health_bar: AnimatedBar = $HBoxContainer/HealthBar
@onready var energy_bar: AnimatedBar = $HBoxContainer/VBoxContainer/EnergyBar
@onready var water_bar: AnimatedBar = $HBoxContainer/VBoxContainer/WaterBar
@onready var food_bar: AnimatedBar = $HBoxContainer/VBoxContainer/FoodBar


func _on_water_need_updated(new_value):
	water_bar.animate(new_value)


func _on_food_need_updated(new_value):
	food_bar.animate(new_value)


func _on_energy_need_updated(new_value):
	energy_bar.animate(new_value)


func _on_health_health_updated(new_health):
	health_bar.animate(new_health)

class_name Creature extends BHCharacter


signal take_damage(damage: int)
signal heal(heal: int)


@export var max_speed := 150.0


@onready var health: Health = $Health
@onready var sprite: Sprite2D = $Sprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


var speed := max_speed


func _on_take_damage(damage: int) -> void:
	take_damage.emit(damage)


func _on_heal(health_point: int) -> void:
	heal.emit(health_point)

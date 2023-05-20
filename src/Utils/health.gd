class_name Health
extends Node


signal health_updated(new_health: int)
signal heal
signal hit
signal die


@export var max_health: int = 100
@export var hurtable: bool = true


@onready var health: int = max_health
@onready var damage_timer: DamageTimer = $DamageTimer


func add_health(health_point: int) -> void:
	health += health_point
	if health > health_point:
		health = health_point
	heal.emit()
	health_updated.emit(health)


func take_damage(damage: int):
	if not is_dead() and can_take_damage():
		damage_timer.start_timer() 
		if damage > health:
			damage = health
		health -= damage
		hit.emit()
		health_updated.emit(health)
		if is_dead():
			die.emit()


func is_dead() -> bool:
	return health <= 0


func can_take_damage() -> bool:
	return hurtable and damage_timer.can_take_damage

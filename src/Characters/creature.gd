class_name Creature extends BHCharacter


signal take_damage(damage: int)
signal heal(heal: int)


@onready var health: Health = $Health
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	pass


func _on_take_damage(damage: int) -> void:
	take_damage.emit(damage)


func _on_heal(health_point: int) -> void:
	heal.emit(health_point)

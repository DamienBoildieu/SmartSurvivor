class_name BuildingSite
extends StaticBody2D


signal building_begin(site: BuildingSite)
signal building_complete(site: BuildingSite)
signal building_update(site: BuildingSite)
signal building_pause(site: BuildingSite)
signal building_resume(site: BuildingSite)


@export var building_modulate: Color = Color(1.0, 1.0, 1.0, 0.5)


var recipe: Recipe:
	get:
		return recipe
	set(new_recipe):
		recipe = new_recipe
		if is_ready:
			update()


var timer_cycles: int = 0
var is_ready: bool = false
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interaction_shape: CollisionShape2D = $InteractionArea/CollisionShape2D
@onready var building_timer: Timer = $Timer
@onready var display_container: Node2D = $DisplayContainer
@onready var animated_bar: AnimatedBar = $AnimatedBar


func _ready() -> void:
	is_ready = true
	update()


func begin_building() -> void:
	animated_bar.value = 0
	building_timer.start()
	building_begin.emit(self)


func pause() -> void:
	building_timer.paused = true
	building_pause.emit(self)


func resume() -> void:
	building_timer.paused = false
	building_pause.emit(self)


func _on_timer_timeout():
	timer_cycles += 1
	animated_bar.animate(timer_cycles)
	building_update.emit(self)
	if timer_cycles >= recipe.construction_time:
		building_timer.stop()
		building_complete.emit(self)


func update() -> void:
	sprite.texture = recipe.texture
	collision.shape.size = recipe.texture.get_size()
	interaction_shape.shape.radius = collision.shape.size.x
	var offset := collision.position
	offset.y -= collision.shape.size.y
	display_container.position = offset
	animated_bar.max_value = recipe.construction_time
	animated_bar.value = 0

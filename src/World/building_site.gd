class_name BuildingSite
extends StaticBody2D


signal building_complete(site: BuildingSite)


@export var building_modulate: Color = Color(1.0, 1.0, 1.0, 0.5)


var recipe: Recipe:
	get:
		return recipe
	set(new_recipe):
		recipe = new_recipe
		if is_ready:
			building_site_update()


var cumulated_time: float = 0.
var is_ready: bool = false
var nb_workers: int = 0
var is_finished: bool = false
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interaction_shape: CollisionShape2D = $InteractionArea/CollisionShape2D
@onready var animated_bar: AnimatedBar = $DisplayContainer/AnimatedBar
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var display_container: Node2D = $DisplayContainer


func _ready() -> void:
	is_ready = true
	building_site_update()


func _process(delta):
	if not is_finished and nb_workers > 0:
		update_work(cumulated_time + nb_workers * delta)
		if cumulated_time > recipe.construction_time:
			complete_build()


func add_worker(new_workers: int) -> void:
	nb_workers += new_workers
	if work_in_progress():
		audio.play()


func remove_workers(formers_workers: int) -> void:
	nb_workers -= formers_workers
	if nb_workers < 0:
		nb_workers = 0
	if not work_in_progress():
		audio.stop()


func reset_work() -> void:
	update_work(0)


func building_site_update() -> void:
	sprite.texture = recipe.texture
	collision.shape.size = recipe.texture.get_size()
	interaction_shape.shape.radius = collision.shape.size.x
	var offset: Vector2 = collision.position - collision.shape.size/2
	offset.y -= collision.shape.size.y/2
	display_container.position = offset
	var bar_scale: float = collision.shape.size.x/animated_bar.size.x
	display_container.scale = Vector2(bar_scale, bar_scale)
	animated_bar.max_value = recipe.construction_time
	reset_work()
	is_finished = false


func update_work(value: float) -> void:
	cumulated_time = value
	animated_bar.value = value


func work_in_progress() -> bool:
	return not is_finished and nb_workers > 0


func complete_build() -> void:
	audio.stop()
	is_finished = true
	building_complete.emit(self)

class_name PlaceArea
extends Area2D


signal build(recipe: Recipe)
signal cancel()


@export var valid_modulate: Color = Color.GREEN
@export var invalid_modulate: Color = Color.RED

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var build_player: AudioStreamPlayer2D = $BuildPlayer
@onready var error_player: AudioStreamPlayer = $ErrorPlayer
var recipe: Recipe
var has_conflict := false


func update(new_recipe: Recipe) -> void:
	sprite.texture = new_recipe.texture
	collision_shape.shape.size = new_recipe.texture.get_size()
	recipe = new_recipe


func activate() -> void:
	collision_shape.disabled = false
	check_conflicts()
	visible = true


func deactivate() -> void:
	collision_shape.disabled = true
	visible = false


func build_scene() -> void:
	if not has_conflict:
		build_player.play()
		build.emit(recipe)
	else:
		error_player.play()

func cancel_build() -> void:
	cancel.emit()


func _on_area_entered(_area: Area2D) -> void:
	check_conflicts()


func _on_area_exited(_area: Area2D) -> void:
	check_conflicts()


func _on_body_entered(_body: Node2D) -> void:
	check_conflicts()


func _on_body_exited(_body: Node2D) -> void:
	check_conflicts()


func check_conflicts() -> void:
	var nb_overlap := get_overlapping_areas().size()
	nb_overlap += get_overlapping_bodies().size()
	has_conflict = nb_overlap != 0
	var edges_color := Vector3(valid_modulate.r, valid_modulate.g, valid_modulate.b)
	if has_conflict:
		edges_color = Vector3(invalid_modulate.r, invalid_modulate.g, invalid_modulate.b)
	sprite.material.set_shader_parameter("edges_color", edges_color)

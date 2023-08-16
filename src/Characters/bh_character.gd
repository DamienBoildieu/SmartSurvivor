class_name BHCharacter extends CharacterBody2D


@export var behavior: BHNode


func _ready() -> void:
	behavior._setup({"target": self})


func _process(delta: float) -> void:
	behavior._process_node(delta)


func _physics_process(delta: float) -> void:
	behavior._process_physics_node(delta)
	_update_animation()
	move_and_slide()


func _update_animation() -> void:
	pass

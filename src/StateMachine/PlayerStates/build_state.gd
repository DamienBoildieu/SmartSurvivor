class_name BuildState
extends CharacterState


var building_site: BuildingSite:
	get:
		return building_site
	set(new_site):
		if building_site != null:
			building_site.building_complete.disconnect(_on_building_complete)
		building_site = new_site
		if building_site != null:
			building_site.building_complete.connect(_on_building_complete)


func _enter_state(arguments := {}) -> void:
	building_site = arguments["building_site"] as BuildingSite
	building_site.add_worker(character.work_force)
	character.state = TopDownCharacter.AnimationState.IDLE


func _state_inputs(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		stop_build()


func _on_building_complete(_building_site: BuildingSite) -> void:
	stop_build()


func stop_build() -> void:
	building_site.remove_workers(character.work_force)
	building_site = null
	character.stop_build()

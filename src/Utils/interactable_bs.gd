class_name InteractableBS
extends InteractableModulate


var building_site: BuildingSite


func _setup(params: Dictionary = {}) -> void:
	building_site = params["building_site"]
	super({"sprite": building_site.sprite})


func _interact_with(other: Node2D) -> void:
	var charac := other as TopDownCharacter
	if charac != null:
		charac.resume_build(building_site)

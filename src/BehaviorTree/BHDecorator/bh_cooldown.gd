class_name BHCooldown extends BHDecorator


class CooldownData:
	var available := false
	var time_spent := 0.0


@export var cooldown := 1.0
@export var cooldown_on_end := true


var cooldown_info := {
	"process": CooldownData.new(),
	"physics_process": CooldownData.new()
}


func start_cooldown(process_info: CooldownData) -> void:
	process_info.available = false
	process_info.time_spent = 0.0


func check_cooldown(process_info: CooldownData, delta: float) -> void:
	if process_info.available:
		return
	process_info.time_spent += delta
	if process_info.time_spent >= cooldown:
		process_info.available = true


func _process(func_name: String, delta: float) -> StateEnum:
	var process_info: CooldownData
	if func_name == "_process_physics_node":
		process_info = cooldown_info["physics_process"] as CooldownData
	else:
		process_info = cooldown_info["process"] as CooldownData
	check_cooldown(process_info, delta)
	if process_info.available:
		if not cooldown_on_end:
			start_cooldown(process_info)
		var ret_code := child.call(func_name, delta) as StateEnum
		if cooldown_on_end and (ret_code == StateEnum.SUCCESS or ret_code == StateEnum.FAIL):
			start_cooldown(process_info)
		return ret_code
	else:
		return StateEnum.FAIL

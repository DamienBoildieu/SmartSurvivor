extends Timer


var can_take_damage: bool = true


func start_timer(time_sec: float = -1) -> void:
	can_take_damage = false
	start(time_sec)


func _on_timeout() -> void:
	can_take_damage = true

class_name AnimatedBar
extends TextureProgressBar


@export_category("Tween parameters")
@export var tween_duration: float = 0.7
@export var tween_trans: Tween.TransitionType = Tween.TRANS_LINEAR
@export var tween_ease: Tween.EaseType = Tween.EASE_IN_OUT


func animate(end):
	get_tree().create_tween().tween_property(self, "value", end, tween_duration).set_trans(tween_trans).set_ease(tween_ease)

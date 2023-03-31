extends TextureProgressBar

class_name AnimatedBar


@export var tween_duration: float = 0.7
@export var tween_trans: Tween.TransitionType = Tween.TRANS_LINEAR
@export var tween_ease: Tween.EaseType = Tween.EASE_IN_OUT


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func animate(end):
	get_tree().create_tween().tween_property(self, "value", end, tween_duration).set_trans(tween_trans).set_ease(tween_ease)

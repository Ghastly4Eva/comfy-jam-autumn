extends CanvasLayer
class_name TransitionAnimation
signal transition_point_reached

const TRANSITION_ANIMATION = preload("uid://drfb048q4yg")
@export var animation : AnimatedSprite2D
var fade_in : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if fade_in:
		animation.play("run")
	else:
		animation.play_backwards("run")
	animation.animation_finished.connect(_animation_finished)

func _animation_finished() -> void:
	transition_point_reached.emit()
	self.queue_free()

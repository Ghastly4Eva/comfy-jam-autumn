extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func fade_out() -> bool:
	layer = 10
	animation_player.play("fade_out")
	await animation_player.animation_finished
	return true

func fade_in() -> bool:
	layer = 10
	animation_player.play("fade_in")
	await animation_player.animation_finished
	layer = 1
	return true

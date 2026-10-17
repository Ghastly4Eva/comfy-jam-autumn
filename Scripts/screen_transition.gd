extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $Control/AnimatedSprite2D

func fade_out() -> bool:
	layer = 10
	#animation_player.play("fade_out")
	animated_sprite_2d.play("fade_out")
	#await animation_player.animation_finished
	await animated_sprite_2d.animation_finished
	return true

func fade_in() -> bool:
	layer = 10
	#animation_player.play("fade_in")
	animated_sprite_2d.play("fade_in")
	#await animation_player.animation_finished
	await animated_sprite_2d.animation_finished
	layer = 1
	return true

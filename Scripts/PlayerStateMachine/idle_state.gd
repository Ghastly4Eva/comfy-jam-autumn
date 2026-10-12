extends State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO

func process_frame(_delta: float) -> State:
	parent.animations.play(animation_name)
	if parent.facing_direction == 'down':
		animation_name = 'idle_down'
	elif parent.facing_direction == 'up':
		animation_name = 'idle_up'
	if parent.facing_direction == 'right':
		animation_name = 'idle_right'
	elif parent.facing_direction == 'left':
		animation_name = 'idle_left'
	return null

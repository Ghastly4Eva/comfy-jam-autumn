extends State

@export var idle: State
var vel_x = 0
var vel_y = 0

func enter() -> void:
	super()
	pass

func process_frame(_delta: float) -> State:
	parent.animations.play(animation_name)
	if parent.input_direction.y == -1:
		animation_name = 'walk_up'
	elif parent.input_direction.y == 1:
		animation_name = 'walk_down'
	if parent.input_direction.x == -1:
		animation_name = 'walk_left'
	elif parent.input_direction.x == 1:
		animation_name = 'walk_right'
	return null

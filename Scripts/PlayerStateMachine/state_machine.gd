extends Node

@export var idle: State
@export var walk: State

@export var starting_state: State
var current_state: State
var velocity

var player


func init(parent: Player) -> void:
	player = parent
	for child in get_children():
		child.parent = parent
	
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(_event: InputEvent) -> void:
	var new_state = null
	if Input.is_action_pressed('move_down') or Input.is_action_pressed('move_up') or Input.is_action_pressed('move_right') or Input.is_action_pressed('move_left'):
		new_state = walk
	else: new_state = idle
	
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
	if player.input_direction.y == -1:
		player.facing_direction = 'up'
	elif player.input_direction.y == 1:
		player.facing_direction = 'down'
	if player.input_direction.x == -1:
		player.facing_direction = 'left'
	elif player.input_direction.x == 1:
		player.facing_direction = 'right'

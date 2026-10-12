class_name Player
extends CharacterBody2D


@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $StateMachine
@onready var candy_icons: Sprite2D = $CandyIcons


var input_direction: Vector2
var facing_direction: String
var can_move: bool = true;

func _ready() -> void:
	state_machine.init(self)
	candy_icons.visible = false;
	can_move = false;
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Tutorial.dialogue"), "start")
	await DialogueManager.dialogue_ended
	can_move = true;
	pass

func get_input():
	if can_move == true:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * state_machine.current_state.move_speed

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	get_input()
	move_and_slide()

func picked_up_item(passeditem: int) -> void:
	candy_icons.visible = true;
	candy_icons.frame = passeditem;
	pass

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

class_name Player
extends CharacterBody2D


@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $StateMachine
@onready var candy_icons: Sprite2D = $CandyIcons
@onready var time_label: Label = $Camera2D/TimeLabel
@onready var front_door_scene: Node2D = $FrontDoorScene

@onready var pick_up: AudioStreamPlayer2D = $pick_up
@onready var drop_item: AudioStreamPlayer2D = $drop_item


var input_direction: Vector2
var facing_direction: String
var can_move: bool = true;
var held_item_id: int = -1;
var is_holding_item: bool = false;
#0 - apple
#1 - coco
#2 - wrapper
#3 - candy corn
#4 - eyeball


func _ready() -> void:
	state_machine.init(self)
	candy_icons.visible = false;
	can_move = false;
	time_label.text = "6:00 PM"
	
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Tutorial.dialogue"), "start")
	await DialogueManager.dialogue_ended
	can_move = true;
	
	pass

func get_input():
	if can_move == true:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * state_machine.current_state.move_speed
	
	if Input.is_action_just_pressed("ThrowItem") and is_holding_item == true:
		ClearHeldItem()
		drop_item.play()

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	get_input()
	move_and_slide()

func picked_up_item(passeditem: int) -> void:
	candy_icons.visible = true;
	candy_icons.frame = passeditem;
	held_item_id = passeditem;
	is_holding_item = true;
	
	pick_up.play()
	pass

func ClearHeldItem() -> void:
	is_holding_item = false;
	candy_icons.visible = false;
	held_item_id = -1;
	

func AdvanceTime() -> void:
	if time_label.text == "6:00 PM":
		time_label.text = "7:00 PM"
	elif time_label.text == "7:00 PM":
		time_label.text = "8:00 PM"
	elif time_label.text == "8:00 PM":
		time_label.text = "9:00 PM"
	elif time_label.text == "9:00 PM":
		time_label.text = "10:00 PM"
	elif time_label.text == "10:00 PM":
		time_label.text = "11:00 PM"
		await ScreenTransition.fade_out()
		get_tree().change_scene_to_file("res://Scenes/EndingCutscene.tscn")
	
	pass

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

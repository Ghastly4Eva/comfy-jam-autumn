extends Area2D

var player_in_range : bool = false
var in_dialogue = false

var cat_notice_dialogue_scene = false

@onready var player: Player = $"../CharacterBody2D"
@onready var door_scene: Node2D = $"../CharacterBody2D/FrontDoorScene"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var front_door_scene: Node2D = $"../CharacterBody2D/FrontDoorScene"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	cat_notice_dialogue_scene = false;
	sprite.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		if player.time_label.text == "10:00 PM":
			player.can_move = false;
			player_in_range = false;
			await ScreenTransition.fade_out()
			await door_scene.ShowDoorAdult()
			await ScreenTransition.fade_in()
			
			await door_scene.AdultArrivesDoor()
			
			await ScreenTransition.fade_out()
			door_scene.HideDoor()
			await ScreenTransition.fade_in()
			player.can_move = true;
			player_in_range = true;
			pass
		else:
			player.can_move = false;
			player_in_range = false;
			await ScreenTransition.fade_out()
			await door_scene.ShowDoor()
			await ScreenTransition.fade_in()
			
			await door_scene.ActiveDoor()
			
			await ScreenTransition.fade_out()
			door_scene.HideDoor()
			await ScreenTransition.fade_in()
			player.can_move = true;
			player_in_range = true;
			
			if player.time_label.text == "6:00 PM" and front_door_scene.treater_waiting == true and cat_notice_dialogue_scene == false:
				player.can_move = false;
				player_in_range = false;
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/NoticesCat.dialogue"), "start")
				await DialogueManager.dialogue_ended
				player.can_move = true;
				cat_notice_dialogue_scene = true;
				#player_in_range = true;
		
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		sprite.visible = true;
		sprite.play("idle");
		player_in_range = true;

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false;
		sprite.stop()
		sprite.visible = false;

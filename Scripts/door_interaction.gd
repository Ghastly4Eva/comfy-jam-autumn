extends Area2D

var player_in_range : bool = false
var in_dialogue = false

@onready var player: Player = $"../CharacterBody2D"
@onready var door_scene: Node2D = $"../CharacterBody2D/FrontDoorScene"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	sprite.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		player.can_move = false;
		player_in_range = false;
		await ScreenTransition.fade_out()
		await door_scene.ShowDoor()
		await ScreenTransition.fade_in()
		
		await get_tree().create_timer(0.2).timeout
		
		await ScreenTransition.fade_out()
		ScreenTransition.fade_in()
		await door_scene.ActiveDoor()
		
		await ScreenTransition.fade_out()
		door_scene.HideDoor()
		await ScreenTransition.fade_in()
		player.can_move = true;
		player_in_range = true;
		
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

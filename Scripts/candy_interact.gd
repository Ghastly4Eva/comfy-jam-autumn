extends Area2D

var player_in_range : bool = false
var candy_option : int = 0
var interaction_step: int = 0

#0 - apple
#1 - coco
#2 - wrapper
#3 - candy corn
#4 - eyeball

@onready var player: Player = $"../../CharacterBody2D"
@onready var indicator_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var icon_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	indicator_sprite.visible = false;
	icon_sprite.visible = false;
	#Activated()

func Activated() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	candy_option = randi_range(0, 4)
	print("Candy: " + str(candy_option))

func ChooseCandy(input)-> void:
	candy_option = input
	print("Candy Changing: " + str(candy_option))

func Deactivated() -> void:
	body_entered.disconnect(_on_body_entered)
	body_exited.disconnect(_on_body_exited)
	indicator_sprite.visible = false;
	player_in_range = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("ui_accept"):
		if interaction_step == 0:
			interaction_step = 1
			await interacted()
		elif interaction_step == 1:
			interaction_step = 0
			await confirm()
		
	pass

func interacted() -> void:
	icon_sprite.visible = true;
	icon_sprite.frame = candy_option
	animation_player.play("icon_idle")
	pass

func confirm() -> void:
	animation_player.stop()
	icon_sprite.visible = false;
	player.picked_up_item(candy_option)
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		interaction_step = 0
		
		indicator_sprite.visible = true;
		indicator_sprite.play("idle");
		player_in_range = true;

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false;
		indicator_sprite.stop()
		indicator_sprite.visible = false;
		icon_sprite.visible = false;
		animation_player.stop()

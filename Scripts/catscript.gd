extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

@onready var cat_meow_1: AudioStreamPlayer2D = $cat_meow1
@onready var cat_meow_2: AudioStreamPlayer2D = $cat_meow2
@onready var cat_meow_3: AudioStreamPlayer2D = $cat_meow3

@onready var shuffleshuffle_2: AudioStreamPlayer2D = $shuffleshuffle2
@onready var shuffleshuffle_1: AudioStreamPlayer2D = $shuffleshuffle1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(144, 123.5)
	pass # Replace with function body.

func ShuffleSound() -> void:
	var randnum = randi_range(1, 2)
	
	if randnum == 1:
		shuffleshuffle_1.pitch_scale = randf_range(0.8, 1.0)
		shuffleshuffle_1.play()
	else:
		shuffleshuffle_2.pitch_scale = randf_range(0.8, 1.0)
		shuffleshuffle_2.play()
	pass

func ChangeLocation() -> void:
	var randnum = randi_range(1, 3)
	
	if randnum == 1:
		position = Vector2(144, 123.5)
	elif randnum == 2:
		position = Vector2(30, -11.5)
	elif randnum == 3:
		position = Vector2(88, -29)
	
	var randnum2 = randi_range(1, 5)
	
	if randnum2 == 1:
		sprite.frame = 0
	elif randnum2 == 2:
		sprite.frame = 1
	elif randnum2 == 3:
		sprite.frame = 2
	elif randnum2 == 4:
		sprite.frame = 3
	elif randnum2 == 5:
		sprite.frame = 4
	pass
	
	var randsound = randi_range(1,3)
	if randsound == 1:
		cat_meow_1.pitch_scale = randf_range(0.8, 1.0)
		cat_meow_1.play()
	elif randsound == 2:
		cat_meow_2.pitch_scale = randf_range(0.8, 1.0)
		cat_meow_2.play()
	elif randsound == 3:
		cat_meow_3.pitch_scale = randf_range(0.8, 1.0)
		cat_meow_3.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

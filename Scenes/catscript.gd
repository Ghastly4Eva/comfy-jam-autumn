extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(144, 123.5)
	pass # Replace with function body.

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

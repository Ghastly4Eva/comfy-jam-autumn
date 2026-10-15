extends AudioStreamPlayer2D

@onready var front_door: Node2D = $"../CharacterBody2D/FrontDoorScene"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await DialogueManager.dialogue_ended
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

@onready var animation_player: AnimationPlayer = $EndingLabel/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Ending.dialogue"), "start")
	await DialogueManager.dialogue_ended
	animation_player.play("Show_End")
	#the end

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

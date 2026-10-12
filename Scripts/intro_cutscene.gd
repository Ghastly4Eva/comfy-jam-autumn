extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Intro.dialogue"), "start")
	await DialogueManager.dialogue_ended
	await ScreenTransition.fade_out()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	ScreenTransition.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

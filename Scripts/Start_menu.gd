extends Control

@onready var UI_SFX = $UI_SFX
@onready var hover = load("res://Audio/sfx_menu_hover.wav")
@onready var select = load("res://Audio/sfx_menu_select.wav")
@onready var back = load("res://Audio/sfx_menu_back.wav")

enum display {
	BLANK,
	CREDITS,
	SETTINGS
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/IntroCutscene.tscn")
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

#func change_display(x) -> void:
	#match x:
		#"blank":
			#


func _on_button_mouse_entered() -> void:
	UI_SFX.stream = hover
	UI_SFX.play()
	await $UI_SFX.finished
	UI_SFX.stop()



func _on_any_button_pressed() -> void:
	UI_SFX.stream = select
	UI_SFX.play()
	await $UI_SFX.finished
	UI_SFX.stop()
	

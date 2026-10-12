extends Node2D

@onready var treater1: Sprite2D = $treater1
@onready var treater2: Sprite2D = $treater2
@onready var treater3: Sprite2D = $treater3
@onready var treater4: Sprite2D = $treater4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false;
	treater1.visible = false;
	treater2.visible = false;
	treater3.visible = false;
	treater4.visible = false;
	pass # Replace with function body.

func ShowDoor() -> void:
	visible = true;

func HideDoor() -> void:
	visible = false;

func ActiveDoor() -> void:
	ChooseRandomSprite()
	await ChooseRandomDialogue()
	

func ChooseRandomDialogue() -> void:
	var randnum = randi_range(1, 2)
	if randnum == 1:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/TreaterDialogue1.dialogue"), "start")
	if randnum == 2:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/TreaterDialogue2.dialogue"), "start")
		
	await DialogueManager.dialogue_ended

func ChooseRandomSprite() -> void:
	var randnum = randi_range(1, 4)
	if randnum == 1:
		treater2.visible = false;
		treater3.visible = false;
		treater4.visible = false;
		
		treater1.visible = true;
	if randnum == 2:
		treater1.visible = false;
		treater3.visible = false;
		treater4.visible = false;
		
		treater2.visible = true;
	if randnum == 3:
		treater1.visible = false;
		treater2.visible = false;
		treater4.visible = false;
		
		treater3.visible = true;
	if randnum == 4:
		treater1.visible = false;
		treater2.visible = false;
		treater3.visible = false;
		
		treater4.visible = true;
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

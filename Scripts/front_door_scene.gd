extends Node2D

@onready var treater1: Sprite2D = $treater1
@onready var treater2: Sprite2D = $treater2
@onready var treater3: Sprite2D = $treater3
@onready var treater4: Sprite2D = $treater4
@onready var candy_interact_activer: Node2D = $"../../CandyInteractActiver"

@onready var player: Player = $".."

var wanted_item_id : int
#0 - apple
#1 - coco
#2 - wrapper
#3 - candy corn
#4 - eyeball

var treater_waiting : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false;
	treater1.visible = false;
	treater2.visible = false;
	treater3.visible = false;
	treater4.visible = false;
	treater_waiting = false;
	pass # Replace with function body.

func ShowDoor() -> void:
	visible = true;

func HideDoor() -> void:
	visible = false;

func ActiveDoor() -> void:
	if treater_waiting == false:
		ChooseRandomSprite()
		await ChooseRandomDialogue()
		candy_interact_activer.RandomizeInteracts()
		treater_waiting = true
	else:
		await TreaterCheck()

func TreaterCheck() -> void:
	if wanted_item_id == player.held_item_id:
		print("Correct!!")
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/CorrectTreater.dialogue"), "start")
		await DialogueManager.dialogue_ended
		treater_waiting = false
		player.ClearHeldItem()
	elif player.held_item_id == -1:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/NothingTreater.dialogue"), "start")
		await DialogueManager.dialogue_ended
	else: 
		print("Wronggggg")
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/WrongTreater.dialogue"), "start")
		await DialogueManager.dialogue_ended

func ChooseRandomDialogue() -> void:
	var randnum = randi_range(1, 3)
	if randnum == 1:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/TreaterDialogue1.dialogue"), "start")
		wanted_item_id = 3
		
	if randnum == 2:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/TreaterDialogue2.dialogue"), "start")
		wanted_item_id = 1
	
	if randnum == 3:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/TreaterDialogue3.dialogue"), "start")
		wanted_item_id = 4
		
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

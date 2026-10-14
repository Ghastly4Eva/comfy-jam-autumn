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
var treater_dialogues: Array[int] = [1, 2, 3, 4]
var treater_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	visible = false;
	treater1.visible = false;
	treater2.visible = false;
	treater3.visible = false;
	treater4.visible = false;
	treater_waiting = false;
	ShuffleTreaters()
	pass # Replace with function body.

func ShowDoor() -> void:
	visible = true;

func HideDoor() -> void:
	visible = false;

func ActiveDoor() -> void:
	if treater_waiting == false:
		await ChooseRandomDialogue()
		candy_interact_activer.RandomizeInteracts()
		treater_waiting = true
	else:
		await TreaterCheck()

func TreaterCheck() -> void:
	if wanted_item_id == player.held_item_id:
		print("Correct!!")
		if treater1.visible == true:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/CorrectTreater1.dialogue"), "start")
			await DialogueManager.dialogue_ended
		elif treater2.visible == true:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/CorrectTreater2.dialogue"), "start")
			await DialogueManager.dialogue_ended
		elif treater3.visible == true:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/CorrectTreater3.dialogue"), "start")
			await DialogueManager.dialogue_ended
		elif treater4.visible == true:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/CorrectTreater4.dialogue"), "start")
			await DialogueManager.dialogue_ended
		
		treater_waiting = false
		player.AdvanceTime()
		player.ClearHeldItem()
	elif player.held_item_id == -1:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/NothingTreater.dialogue"), "start")
		await DialogueManager.dialogue_ended
	else: 
		print("Wronggggg")
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/WrongTreater.dialogue"), "start")
		await DialogueManager.dialogue_ended

func ShuffleTreaters() -> void:
	treater_dialogues = [1, 2, 3, 4]
	treater_dialogues.shuffle()
	treater_index = 0

func ChooseRandomDialogue() -> void:
	if treater_index >= treater_dialogues.size():
		ShuffleTreaters()
	
	var randnum = treater_dialogues[treater_index]
	treater_index += 1
	
	treater1.visible = false
	treater2.visible = false
	treater3.visible = false
	treater4.visible = false
	
	var variant = randi_range(0, 4)
	if randnum == 1:
		treater1.visible = true
		
		if variant == 0:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater1Variant0.dialogue"), "start")
			wanted_item_id = 0
		elif variant == 1:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater1Variant1.dialogue"), "start")
			wanted_item_id = 1
		elif variant == 2:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater1Variant2.dialogue"), "start")
			wanted_item_id = 2
		elif variant == 3:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater1Variant3.dialogue"), "start")
			wanted_item_id = 3
		elif variant == 4:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater1Variant4.dialogue"), "start")
			wanted_item_id = 4
	
	elif randnum == 2:
		treater2.visible = true
		
		if variant == 0:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater2Variant0.dialogue"), "start")
			wanted_item_id = 0
		elif variant == 1:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater2Variant1.dialogue"), "start")
			wanted_item_id = 1
		elif variant == 2:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater2Variant2.dialogue"), "start")
			wanted_item_id = 2
		elif variant == 3:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater2Variant3.dialogue"), "start")
			wanted_item_id = 3
		elif variant == 4:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater2Variant4.dialogue"), "start")
			wanted_item_id = 4
	
	elif randnum == 3:
		treater3.visible = true
		
		if variant == 0:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater3Variant0.dialogue"), "start")
			wanted_item_id = 0
		elif variant == 1:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater3Variant1.dialogue"), "start")
			wanted_item_id = 1
		elif variant == 2:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater3Variant2.dialogue"), "start")
			wanted_item_id = 2
		elif variant == 3:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater3Variant3.dialogue"), "start")
			wanted_item_id = 3
		elif variant == 4:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater3Variant4.dialogue"), "start")
			wanted_item_id = 4
	
	elif randnum == 4:
		treater4.visible = true
		
		if variant == 0:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater4Variant0.dialogue"), "start")
			wanted_item_id = 0
		elif variant == 1:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater4Variant1.dialogue"), "start")
			wanted_item_id = 1
		elif variant == 2:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater4Variant2.dialogue"), "start")
			wanted_item_id = 2
		elif variant == 3:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater4Variant3.dialogue"), "start")
			wanted_item_id = 3
		elif variant == 4:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Treater4Variant4.dialogue"), "start")
			wanted_item_id = 4
	
	await DialogueManager.dialogue_ended

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

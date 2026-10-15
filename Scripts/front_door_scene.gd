extends Node2D

@onready var treater1: Sprite2D = $treater1
@onready var treater2: Sprite2D = $treater2
@onready var treater3: Sprite2D = $treater3
@onready var treater4: Sprite2D = $treater4
@onready var candy_interact_activer: Node2D = $"../../CandyInteractActiver"
@onready var the_cat: Node2D = $"../../TheCat"
@onready var animation_player: AnimationPlayer = $PanUpAdultPartyArrivalThing/AnimationPlayer
@onready var pan_up_adult_party_arrival_thing: Sprite2D = $PanUpAdultPartyArrivalThing
@onready var background: Sprite2D = $background

@onready var door_open: AudioStreamPlayer2D = $door_open
@onready var door_close: AudioStreamPlayer2D = $door_close
@onready var knocking: AudioStreamPlayer2D = $"../../Knocking"

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
var treater_variants: Array[int] = [0, 1, 2, 3, 4]
var variant_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	visible = false;
	treater1.visible = false;
	treater2.visible = false;
	treater3.visible = false;
	treater4.visible = false;
	background.visible = true;
	treater_waiting = false;
	pan_up_adult_party_arrival_thing.visible = false;
	ShuffleVariants()
	ShuffleTreaters()
	pass # Replace with function body.

func ShowDoor() -> void:
	visible = true;
	if treater_waiting == false:
		treater1.visible = false
		treater2.visible = false
		treater3.visible = false
		treater4.visible = false
	
	door_open.play()

func ShowDoorAdult() -> void:
	knocking.stop()
	visible = true;
	
	background.visible = false;
	treater1.visible = false;
	treater2.visible = false;
	treater3.visible = false;
	treater4.visible = false;
	
	pan_up_adult_party_arrival_thing.visible = true;
	
	door_open.play()
	knocking.volume_db = -80

func HideDoor() -> void:
	door_close.play()
	visible = false;

func ActiveDoor() -> void:
	if treater_waiting == false:
		knocking.volume_db = -80
		await ChooseRandomDialogue()
		the_cat.ChangeLocation()
		candy_interact_activer.RandomizeInteracts()
		treater_waiting = true
	else:
		await TreaterCheck()

func AdultArrivesDoor() -> void:
	knocking.volume_db = -80
	#knocking.stop()
	
	background.visible = false;
	treater1.visible = false;
	treater2.visible = false;
	treater3.visible = false;
	treater4.visible = false;
	
	pan_up_adult_party_arrival_thing.visible = true;
	animation_player.play("pan_up")
	await animation_player.animation_finished
	
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/AdultDialogue.dialogue"), "start")
	await DialogueManager.dialogue_ended
	
	player.AdvanceTime()

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
		knocking.volume_db = -7
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

func ShuffleVariants() -> void:
	treater_variants = [0, 1, 2, 3, 4]
	treater_variants.shuffle()
	variant_index = 0

func ChooseRandomDialogue() -> void:
	if treater_index >= treater_dialogues.size():
		ShuffleTreaters()
		ShuffleVariants()
	
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

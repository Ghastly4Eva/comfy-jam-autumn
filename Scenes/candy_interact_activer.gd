extends Node2D

@onready var candy_interaction_bath_1: Area2D = $CandyInteractionBath1
@onready var candy_interaction_bath_2: Area2D = $CandyInteractionBath2
@onready var candy_interaction_bed_3: Area2D = $CandyInteractionBed3
@onready var candy_interaction_bed_5: Area2D = $CandyInteractionBed5
@onready var candy_interaction_bed_7: Area2D = $CandyInteractionBed7
@onready var candy_interaction_kitchen_2: Area2D = $CandyInteractionKitchen2
@onready var candy_interaction_kitchen_3: Area2D = $CandyInteractionKitchen3
@onready var candy_interaction_main_4: Area2D = $CandyInteractionMain4
@onready var candy_interaction_main_5: Area2D = $CandyInteractionMain5

@onready var door_scene: Node2D = $"../CharacterBody2D/FrontDoorScene"

var candy_interactions_list: Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	candy_interactions_list = [
		candy_interaction_bath_1,
		candy_interaction_bath_2,
		candy_interaction_bed_3,
		candy_interaction_bed_5,
		candy_interaction_bed_7,
		candy_interaction_kitchen_2,
		candy_interaction_kitchen_3,
		candy_interaction_main_4,
		candy_interaction_main_5
	]
	pass # Replace with function body.

func RandomizeInteracts() -> void:
	for i in candy_interactions_list:
		i.Deactivated()
	
	candy_interactions_list.shuffle()
	
	for i in range(3):
		candy_interactions_list[i].Activated()
	
	var chosen_interaction = candy_interactions_list[randi_range(0, 2)]
	chosen_interaction.ChooseCandy(door_scene.wanted_item_id)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

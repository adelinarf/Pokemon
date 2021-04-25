extends Node

onready var info_box_0 = get_node("Pokemon_info_box/Label")
onready var info_box_0_bar = get_node("Pokemon_info_box/Progress bar/TextureProgress")
onready var info_box_0_level = get_node("Pokemon_info_box/Progress bar/Label")
onready var info_box_1 = get_node("Pokemon_info_box2/Label")
onready var info_box_1_bar = get_node("Pokemon_info_box2/Progress bar/TextureProgress")
onready var info_box_1_level = get_node("Pokemon_info_box2/Progress bar/Label")
onready var info_box_2 = get_node("Pokemon_info_box3/Label")
onready var info_box_2_bar = get_node("Pokemon_info_box3/Progress bar/TextureProgress")
onready var info_box_2_level = get_node("Pokemon_info_box3/Progress bar/Label")
onready var info_box_3 = get_node("Pokemon_info_box4/Label")
onready var info_box_3_bar = get_node("Pokemon_info_box4/Progress bar/TextureProgress")
onready var info_box_3_level = get_node("Pokemon_info_box4/Progress bar/Label")
# Called when the node enters the scene tree for the first time.

onready var a = get_node("Pokemon_info_box/HBoxContainer/select_pokemon")
onready var b = get_node("Pokemon_info_box2/HBoxContainer/select_pokemon")
onready var c = get_node("Pokemon_info_box3/HBoxContainer/select_pokemon")
onready var d = get_node("Pokemon_info_box4/HBoxContainer/select_pokemon")

func _ready() -> void:
	print(PlayerData.player_test)
	print(PlayerData.player_test["Pokedex"][0]["name"])
	delete_box()
	name_boxes()
	select_pokemon()
	
func select_pokemon():
	print ("0",$Pokemon_info_box._on_select_pokemon_button_up())
	print ("1",$Pokemon_info_box2._on_select_pokemon_button_up())
	print ("2",$Pokemon_info_box3._on_select_pokemon_button_up())
	print ("3",$Pokemon_info_box4._on_select_pokemon_button_up())
	
func name_boxes():
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
			info_box_0.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_0_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_0_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 1:
			info_box_1.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_1_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_1_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
			info_box_2.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_2_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_2_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 3:
			info_box_3.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_3_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_3_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass
			
func delete_box():
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass
	if maximum == 0:
		$Pokemon_info_box.visible = true
	if maximum == 1:
		$Pokemon_info_box.visible = true
		$Pokemon_info_box2.visible = true
	elif maximum == 2:
		$Pokemon_info_box.visible = true
		$Pokemon_info_box2.visible = true
		$Pokemon_info_box3.visible = true
	elif maximum == 3:
		$Pokemon_info_box.visible = true
		$Pokemon_info_box2.visible = true
		$Pokemon_info_box3.visible = true
		$Pokemon_info_box4.visible = true

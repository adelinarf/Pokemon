extends Control

onready var a = get_node("first/HBoxContainer/select_pokemon")
onready var b = get_node("VBoxContainer/second/HBoxContainer/select_pokemon2")
onready var c = get_node("VBoxContainer/third/HBoxContainer/select_pokemon3")
onready var d = get_node("VBoxContainer/fourth/HBoxContainer/select_pokemon4")

onready var info_box_0 = get_node("first/Label")
onready var info_box_0_bar = get_node("first/Progress bar/TextureProgress")
onready var info_box_0_level = get_node("first/Progress bar/Label")
onready var info_box_1 = get_node("VBoxContainer/second/Label")
onready var info_box_1_bar = get_node("VBoxContainer/second/Progress bar")
onready var info_box_1_level = get_node("VBoxContainer/second/Progress bar/Label")
onready var info_box_2 = get_node("VBoxContainer/third/Label")
onready var info_box_2_bar = get_node("VBoxContainer/third/Progress bar")
onready var info_box_2_level = get_node("VBoxContainer/third/Progress bar/Label")
onready var info_box_3 = get_node("VBoxContainer/fourth/Label")
onready var info_box_3_bar = get_node("VBoxContainer/fourth/Progress bar/TextureProgress")
onready var info_box_3_level = get_node("VBoxContainer/fourth/Progress bar/Label")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	delete_box()
	name_boxes()
	print (PlayerData.pokemon_selected)

var pokemon = [null,null,null,null]

func name_boxes():
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
			info_box_0.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_0_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_0_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			pokemon[0]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 1:
			info_box_1.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			#info_box_1_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_1_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			pokemon[1]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
			info_box_2.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_2_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_2_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			pokemon[2]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 3:
			info_box_3.text = PlayerData.player_test["Pokedex"][x]["name"] + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_3_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_3_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			pokemon[3]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass
			
func delete_box():
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x=x+1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
	if maximum == 0:
		$first.visible = true
	if maximum == 1:
		$first.visible = true
		$VBoxContainer/second.visible = true
	elif maximum == 2:
		$first.visible = true
		$VBoxContainer/second.visible = true
		$VBoxContainer/third.visible = true
	elif maximum == 3:
		$first.visible = true
		$VBoxContainer/second.visible = true
		$VBoxContainer/third.visible = true
		$VBoxContainer/fourth.visible = true

func _on_select_pokemon_pressed() -> void:
	if a.pressed == true:
		b.pressed = false
		c.pressed = false
		d.pressed = false
		PlayerData.pokemon_selected = pokemon[0]
		

func _on_select_pokemon2_pressed() -> void:
	if b.pressed == true:
		a.pressed = false
		c.pressed = false
		d.pressed = false
		PlayerData.pokemon_selected = pokemon[1]

func _on_select_pokemon3_pressed() -> void:
	if c.pressed == true:
		a.pressed = false
		b.pressed = false
		d.pressed = false
		PlayerData.pokemon_selected = pokemon[2]

func _on_select_pokemon4_pressed() -> void:
	if d.pressed == true:
		a.pressed = false
		b.pressed = false
		c.pressed = false
		PlayerData.pokemon_selected = pokemon[3]

func which_pressed()-> int:
	if a.pressed == true:
		return (pokemon[0])
	elif b.pressed == true:
		return (pokemon[1]) 
	elif c.pressed == true:
		return (pokemon[2])
	elif d.pressed == true:
		return (pokemon[3])
	else:
		return (pokemon[0])

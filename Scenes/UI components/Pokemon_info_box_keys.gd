extends Control
onready var info_box_0 = get_node("Pokemon_info_selection/first/Label")
onready var info_box_0_level = get_node("Pokemon_info_selection/first/Level")
onready var info_box_0_bar = get_node("Pokemon_info_selection/Progress bar/TextureProgress")
onready var info_box_hp = get_node("Pokemon_info_selection/first/Label2")
onready var info_box_1 = get_node("Pokemon_info_selection/Names/second/Label")
onready var info_box_1_level = get_node("Pokemon_info_selection/levels/Label")
onready var info_box_1_bar = get_node("Pokemon_info_selection/Progress bar2/TextureProgress")
onready var info_box1_hp = get_node("Pokemon_info_selection/hp_total/Label")
onready var info_box_2 = get_node("Pokemon_info_selection/Names/third/Label")
onready var info_box_2_bar = get_node("Pokemon_info_selection/Progress bar3/TextureProgress")
onready var info_box_2_level = get_node("Pokemon_info_selection/levels/Label2")
onready var info_box2_hp = get_node("Pokemon_info_selection/hp_total/Label2")
onready var info_box_3 = get_node("Pokemon_info_selection/Names/fourth/Label")
onready var info_box_3_bar = get_node("Pokemon_info_selection/Progress bar4/TextureProgress")
onready var info_box_3_level = get_node("Pokemon_info_selection/levels/Label3")
onready var info_box3_hp =get_node("Pokemon_info_selection/hp_total/Label3")

onready var menu = get_node("three_option_menu")
onready var slots = get_node("Pokemon_info_selection")


# Called when the node enters the scene tree for the first time.
func _ready():
	name_boxes()
	menu.set_process_unhandled_input(false)

var pokemon = [null,null,null,null] #array of positions in Pokedex
var pokemon_to_fight_id = [null,null,null,null]
func name_boxes():
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
			if PlayerData.player_test["Pokedex"][x]["Nickname"]=="":
				info_box_0.text = PlayerData.player_test["Pokedex"][x]["name"]
			else:
				info_box_0.text = PlayerData.player_test["Pokedex"][x]["name"] + " '" + PlayerData.player_test["Pokedex"][x]["Nickname"] + "' " 
			var info_hp = PlayerData.get_pokemon_info_by_name(PlayerData.player_test["Pokedex"][x]["name"])
			var hp = info_hp[2]["HP"]
			info_box_0_bar.max_value = hp
			info_box_0_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_0_level.text = String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box_hp.text = String(PlayerData.player_test["Pokedex"][x]["HP"])+ "       "+ String(hp)
			pokemon[0]=x
			pokemon_to_fight_id[0] = PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 1:
			if PlayerData.player_test["Pokedex"][x]["Nickname"]=="":
				info_box_1.text = PlayerData.player_test["Pokedex"][x]["name"] 
			else:
				info_box_1.text = PlayerData.player_test["Pokedex"][x]["name"] + "'" + PlayerData.player_test["Pokedex"][x]["Nickname"] + "'" 
			var info_hp1 = PlayerData.get_pokemon_info_by_name(PlayerData.player_test["Pokedex"][x]["name"])
			var hp1 = info_hp1[2]["HP"]
			info_box_1_bar.max_value = hp1
			info_box_1_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_1_level.text = String(PlayerData.player_test["Pokedex"][x]["Level"])
			info_box1_hp.text = String(PlayerData.player_test["Pokedex"][x]["HP"])+ "       "+ String(hp1)
			pokemon[1]=x
			pokemon_to_fight_id[1] = PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
			if PlayerData.player_test["Pokedex"][x]["Nickname"]=="":
				info_box_2.text = PlayerData.player_test["Pokedex"][x]["name"]
			else:
				info_box_2.text = PlayerData.player_test["Pokedex"][x]["name"] + "'" + PlayerData.player_test["Pokedex"][x]["Nickname"] + "'" + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			var info_hp2 = PlayerData.get_pokemon_info_by_name(PlayerData.player_test["Pokedex"][x]["name"])
			var hp2 = info_hp2[2]["HP"]
			info_box_2_bar.max_value = hp2
			info_box_2_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_2_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			info_box2_hp.text = String(PlayerData.player_test["Pokedex"][x]["HP"])+ "       "+ String(hp2)
			pokemon[2]=x
			pokemon_to_fight_id[2] = PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 3:
			if PlayerData.player_test["Pokedex"][x]["Nickname"]=="":
				info_box_3.text = PlayerData.player_test["Pokedex"][x]["name"]
			else:
				info_box_3.text = PlayerData.player_test["Pokedex"][x]["name"] + "'" + PlayerData.player_test["Pokedex"][x]["Nickname"] + "'" + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			var info_hp3 = PlayerData.get_pokemon_info_by_name(PlayerData.player_test["Pokedex"][x]["name"])
			var hp3 = info_hp3[2]["HP"]
			info_box_3_bar.max_value = hp3
			info_box_3_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_3_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			info_box3_hp.text = String(PlayerData.player_test["Pokedex"][x]["HP"])+ "       "+ String(hp3)
			pokemon[3]=x
			pokemon_to_fight_id[3] = PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass


var pokemon_to_change = null
var pokemon_to_change_2 =null
func _on_Pokemon_info_selection_selected_slot(value):
	var selected = value
	if choosing==false:
		pokemon_to_change = value-1
		menu.get_node("menu/Yes").text = "DATA"
		menu.get_node("menu/No").text = "CHANGE"
		menu.get_node("menu/No2").text = "OBJECT"
		menu.visible=true
		menu.set_process_unhandled_input(true)
		slots.set_process_unhandled_input(false)
	elif choosing==true:
		pokemon_to_change_2 = value-1
		change_pokemon_order_in_fight(selected)
	if value == 5:
		if PlayerData.player_test["Fighting"]==true:
			get_tree().change_scene("res://Scenes/Battle_.tscn")
		elif PlayerData.player_test["Fighting"]==false:
			get_tree().change_scene(PlayerData.is_in[1])
	else:
		pass

func change_pokemon_order_in_fight(number):
	var pos1=pokemon[pokemon_to_change]
	var pos2=pokemon[pokemon_to_change_2]
	print (pos1,pos2)
	var change = PlayerData.player_test["Pokedex"][pos1]["Order_in_fight"]
	var change2 = PlayerData.player_test["Pokedex"][pos2]["Order_in_fight"]
	print(change,change2)
	PlayerData.player_test["Pokedex"][pos2]["Order_in_fight"] = change
	PlayerData.player_test["Pokedex"][pos1]["Order_in_fight"] = change2
	var a =PlayerData.player_test["Pokedex"][pos1]["Order_in_fight"]
	var b = PlayerData.player_test["Pokedex"][pos2]["Order_in_fight"]
	print(a,b)
	if PlayerData.fighting_pokemon != pos1:
		pass #PlayerData.fighting_pokemon = pos1
	elif PlayerData.fighting_pokemon != pos2:
		pass #PlayerData.fighting_pokemon = pos2
	choosing=false
	name_boxes()
	
var choosing=false
func _on_three_option_menu_is_pressed(value):
	if value==0:
		PlayerData.pokemon_selected = pokemon[pokemon_to_change]
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page.tscn")
	 #GO TO THE DATA PAGE
	elif value==1:
		choosing=true #let choose a pokemon
	elif value ==2:
		#SHOW IF THIS HAS AN OBJECT
		var position = pokemon[pokemon_to_change]
		if PlayerData.player_test["Pokedex"][position]["Objects"] == null:
			$Label.visible = true
			$Label.text = PlayerData.player_test["Pokedex"][position]["name"] + " has no items."
		else:
			$Label.text = PlayerData.player_test["Pokedex"][position]["name"] + " has a " + PlayerData.player_test["Pokedex"][position]["Objects"]
	menu.visible=false
	menu.set_process_unhandled_input(false)
	slots.set_process_unhandled_input(true)
	

extends Control

onready var a = get_node("first/HBoxContainer/select_pokemon")
onready var b = get_node("VBoxContainer/second/HBoxContainer/select_pokemon2")
onready var c = get_node("VBoxContainer/third/HBoxContainer/select_pokemon3")
onready var d = get_node("VBoxContainer/fourth/HBoxContainer/select_pokemon4")

onready var info_box_0 = get_node("first/Label")
onready var info_box_0_bar = get_node("Progress bar/TextureProgress")
onready var info_box_0_level = get_node("first/Level")
onready var info_box_1 = get_node("VBoxContainer/second/Label")
onready var info_box_1_bar = get_node("Progress bar2/TextureProgress")
onready var info_box_1_level = get_node("levels/Label")
onready var info_box_2 = get_node("VBoxContainer/third/Label")
onready var info_box_2_bar = get_node("Progress bar3/TextureProgress")
onready var info_box_2_level = get_node("levels/Label2")
onready var info_box_3 = get_node("VBoxContainer/fourth/Label")
onready var info_box_3_bar = get_node("Progress bar4/TextureProgress")
onready var info_box_3_level = get_node("levels/Label3")
onready var info_box_hp = get_node("first/Label2")
onready var info_box1_hp = get_node("hp_total/Label")
onready var info_box2_hp = get_node("hp_total/Label2")
onready var info_box3_hp = get_node("hp_total/Label3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(PlayerData.player_test)
	print(PlayerData.player_test["Pokedex"][0]["name"])
	delete_box()
	name_boxes()
	print (PlayerData.fighting_pokemon)

var pokemon = [null,null,null,null]
var pokemon_to_fight_id = [null,null,null,null]
func name_boxes():
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
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
			info_box_1.text = PlayerData.player_test["Pokedex"][x]["name"] + "'" + PlayerData.player_test["Pokedex"][x]["Nickname"] + "'" + "    Level " + String(PlayerData.player_test["Pokedex"][x]["Level"])
			var info_hp1 = PlayerData.get_pokemon_info_by_name(PlayerData.player_test["Pokedex"][x]["name"])
			var hp1 = info_hp1[2]["HP"]
			info_box_1_bar.max_value = hp1
			info_box_1_bar.value = PlayerData.player_test["Pokedex"][x]["HP"]
			info_box_1_level.text = "HP " + String(PlayerData.player_test["Pokedex"][x]["HP"])
			info_box1_hp.text = String(PlayerData.player_test["Pokedex"][x]["HP"])+ "       "+ String(hp1)
			pokemon[1]=x
			pokemon_to_fight_id[1] = PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
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
			
func delete_box():
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x=x+1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
	if maximum == 0:
		$first.visible = true
		$"Progress bar".visible = true
		$Pokemon1.visible = true
	if maximum == 1:
		$first.visible = true
		$VBoxContainer/second.visible = true
		$"Progress bar".visible = true
		$"Progress bar2".visible = true
		$levels/Label.visible = true
		$hp_total/Label.visible = true
		$Pokemon1.visible = true
		$Pokemon2.visible = true
	elif maximum == 2:
		$first.visible = true
		$VBoxContainer/second.visible = true
		$VBoxContainer/third.visible = true
		$"Progress bar".visible = true
		$"Progress bar2".visible = true
		$"Progress bar3".visible = true
		$levels/Label.visible = true
		$hp_total/Label.visible = true
		$levels/Label2.visible = true
		$hp_total/Label2.visible = true
		$Pokemon1.visible = true
		$Pokemon2.visible = true
		$Pokemon3.visible = true
	elif maximum == 3:
		$first.visible = true
		$VBoxContainer/second.visible = true
		$VBoxContainer/third.visible = true
		$VBoxContainer/fourth.visible = true
		$"Progress bar".visible = true
		$"Progress bar2".visible = true
		$"Progress bar3".visible = true
		$"Progress bar4".visible = true
		$levels/Label.visible = true
		$hp_total/Label.visible = true
		$levels/Label2.visible = true
		$hp_total/Label2.visible = true
		$levels/Label3.visible = true
		$hp_total/Label3.visible = true
		$Pokemon1.visible = true
		$Pokemon2.visible = true
		$Pokemon3.visible = true
		$Pokemon4.visible = true

func _on_select_pokemon_pressed() -> void:
	if a.pressed == true:
		b.pressed = false
		c.pressed = false
		d.pressed = false
		if PlayerData.player_test["Pokedex"][pokemon[0]]["HP"] != 0 and PlayerData.fighting_pokemon != pokemon[0]:
			PlayerData.fighting_pokemon = PlayerData.player_test["Pokedex"][pokemon[0]]["Order_in_fight"]
		if PlayerData.player_test["Pokedex"][pokemon[0]]["HP"] == 0:
			$Label.visible = true
			$Label.text = PlayerData.player_test["Pokedex"][pokemon[0]]["name"] + " has fainted"
		$Menu.visible = true
	else:
		$Label.visible = false
		$Menu.visible = false
		

func _on_select_pokemon2_pressed() -> void:
	if b.pressed == true:
		a.pressed = false
		c.pressed = false
		d.pressed = false
		if PlayerData.player_test["Pokedex"][pokemon[1]]["HP"] != 0 and PlayerData.fighting_pokemon != pokemon[1]:
			PlayerData.fighting_pokemon = PlayerData.player_test["Pokedex"][pokemon[1]]["Order_in_fight"]
		if PlayerData.player_test["Pokedex"][pokemon[1]]["HP"] == 0:
			$Label.visible = true
			$Label.text = PlayerData.player_test["Pokedex"][pokemon[1]]["name"] + " has fainted"
		$Menu.visible = true
	else:
		$Label.visible = false
		$Menu.visible = false

func _on_select_pokemon3_pressed() -> void:
	if c.pressed == true:
		a.pressed = false
		b.pressed = false
		d.pressed = false
		if PlayerData.player_test["Pokedex"][pokemon[2]]["HP"] != 0 and PlayerData.fighting_pokemon != pokemon[2]:
			PlayerData.fighting_pokemon = PlayerData.player_test["Pokedex"][pokemon[2]]["Order_in_fight"]
		if PlayerData.player_test["Pokedex"][pokemon[2]]["HP"] == 0:
			$Label.visible = true
			$Label.text = PlayerData.player_test["Pokedex"][pokemon[2]]["name"] + " has fainted"
		$Menu.visible = true
	else:
		$Label.visible = false
		$Menu.visible = false

func _on_select_pokemon4_pressed() -> void:
	if d.pressed == true:
		a.pressed = false
		b.pressed = false
		c.pressed = false
		if PlayerData.player_test["Pokedex"][pokemon[3]]["HP"] != 0 and PlayerData.fighting_pokemon != pokemon[3]:
			PlayerData.fighting_pokemon = PlayerData.player_test["Pokedex"][pokemon[3]]["Order_in_fight"]
		if PlayerData.player_test["Pokedex"][pokemon[3]]["HP"] == 0:
			$Label.visible = true
			$Label.text = PlayerData.player_test["Pokedex"][pokemon[3]]["name"] + " has fainted"
		$Menu.visible = true
	else:
		$Label.visible = false
		$Menu.visible = false

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

func _on_Data_pressed() -> void:
	PlayerData.pokemon_selected = which_pressed()
	get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page.tscn")
	#var upper = get_node("Pokemon_info_page/GridContainer2/Label2")
	#var Number = get_node("Pokemon_info_page/GridContainer/fill")
	#var Name = get_node("Pokemon_info_page/GridContainer/fill2")
	#var Type = get_node("Pokemon_info_page/GridContainer/fill3")
	#var EO = get_node("Pokemon_info_page/GridContainer/fill4")
	#var ID = get_node("Pokemon_info_page/GridContainer/fill5")
	#var Objects = get_node("Pokemon_info_page/GridContainer/fill6")
	#var number = which_pressed()
	#var arrays = pokemon_number_in_list()
	#var a = arrays[0]
	#var pokemon_available = arrays[1]
	#found the list of pokemon that has no null elements
	#if $Pokemon_info_page/Button.pressed == true:
	#	print ("BUTTON TRUE")
	#	number = pokemon_available[a-1]
	#var poke_name = PlayerData.player_test["Pokedex"][number]["name"]
	#var lists = PlayerData.get_pokemon_info_by_name(poke_name)
	#var id = lists[0]
	#var type = lists[1]
	#var base = lists[2]
	#Number.text = String(id)
	#for i in range(len(type)):
	#	Type.text = type[i] + "  "
	#Name.text = poke_name
	#EO.text = PlayerData.player_test["name"]
	#ID.text = String(id)
	#if PlayerData.player_test["Pokedex"][number]["Objects"] == null:
	#	Objects.text = "There's no objects"
	#else:
	#	Objects.text = PlayerData.player_test["Pokedex"][number]["Objects"]
	#upper.text = "Level %s" % PlayerData.player_test["Pokedex"][number]["Level"] + "  %s" % poke_name
	#if $Pokemon_info_page/Button.pressed == true:
	#	$Pokemon_info_page.visible=false
	
func _on_Change_pressed() -> void:
	#in the future this functino can change to be only a function to change
	# the order of fight but not to change a pokemon while fighting
	# that can be done by only pressing selected on the before code
	#MAKE THIS FUNCTION AVAILABLE ONLY IF fighting == false
	if PlayerData.player_test["Fighting"]==false and len(PlayerData.player_test["Pokedex"])>1:
		$ItemList.visible = true
		var number = which_pressed()
		var poke = PlayerData.player_test["Pokedex"][number]["Order_in_fight"]
		for x in range(len(PlayerData.player_test["Pokedex"])):
			if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == poke:
				pass
			elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
				pass
			else:
				$ItemList.clear()
				$ItemList.add_item(PlayerData.player_test["Pokedex"][x]["name"])
		# pokemon[x] la posicion 0 esta el primero que va a pelear
	elif PlayerData.player_test["Fighting"]==false and len(PlayerData.player_test["Pokedex"])==1:
		$Menu/Label.visible = true
		$Menu/Label.text = "You only have one pokemon"
	elif PlayerData.player_test["Fighting"]==true:
		$Menu/Label.visible = true
		$Menu/Label.text = "You can't change pokemon order during a fight"
	
func _on_ItemList_item_selected(index: int) -> void:
	var number = which_pressed()
	var name = $ItemList.get_item_text(index)
	var get_position_1 = null
	var get_position_2 = null
	for x in range(len(PlayerData.player_test["Pokedex"])):
		for i in range(len(pokemon_to_fight_id)):
			if PlayerData.player_test["Pokedex"][x]["name"] == name and PlayerData.player_test["Pokedex"][x]["Id number"] == pokemon_to_fight_id[i]:
				get_position_1 = x # The ones who's gonna change 
			else:
				pass
	var change = PlayerData.player_test["Pokedex"][get_position_1]["Order_in_fight"]
	var change2 = PlayerData.player_test["Pokedex"][number]["Order_in_fight"]
	PlayerData.player_test["Pokedex"][number]["Order_in_fight"] = change
	PlayerData.player_test["Pokedex"][get_position_1]["Order_in_fight"] = change2
	#if change == 0:
		#PlayerData.fighting_pokemon = number
	#elif change2 == 0:
		#PlayerData.fighting_pokemon = get_position_1
	print (PlayerData.player_test["Pokedex"][number])
	print (PlayerData.player_test["Pokedex"][get_position_1])
	PlayerData.fighting_pokemon = get_position_1
	name_boxes()
	$ItemList.visible = false
	#if PlayerData.player_test["Fighting"] == true:
		#PlayerData.pokemon_participate_in_battle.append(get_position_1)
		#PlayerData.pokemon_participate_in_battle.append(number)

func _on_Object_pressed() -> void:
	var position = which_pressed()
	if PlayerData.player_test["Pokedex"][position]["Objects"] == null:
		$Menu/Label.visible = true
		$Menu/Label.text = PlayerData.player_test["Pokedex"][position]["name"] + " has no items."
	else:
		$Menu/Label.text = PlayerData.player_test["Pokedex"][position]["name"] + " has a " + PlayerData.player_test["Pokedex"][position]["Objects"]

func _on_Exit_pressed() -> void:
	$Menu.visible=false

		
func _on_Exit2_pressed():
	if PlayerData.player_test["Fighting"] == true:
		get_tree().change_scene("res://Scenes/Battle_.tscn")
	elif PlayerData.player_test["Fighting"]==false:
		get_tree().change_scene(PlayerData.is_in[1])

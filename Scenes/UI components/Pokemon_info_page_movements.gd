extends Control

onready var upper = get_node("GridContainer2/Label2")
onready var number = PlayerData.pokemon_selected
onready var move1 = get_node("move1")
onready var move2 = get_node("move2")
onready var move3 = get_node("move3")
onready var move4 = get_node("move4")
onready var poke_sprite = get_node("Sprite")
var id = null

func _ready() -> void:
	change_labels()
	PlayerData.set_pokemon_sprite(poke_sprite,id,false)
	print (number)

func change_labels():
	var poke_name = PlayerData.player_test["Pokedex"][number]["name"]
	var lists = PlayerData.get_pokemon_info_by_name(poke_name)
	id = lists[0]
	var type = lists[1]
	var base = lists[2]
	upper.text = "Level %s" % PlayerData.player_test["Pokedex"][number]["Level"] 
	$nickname.text = PlayerData.player_test["Pokedex"][number]["Nickname"]
	show_pokemon_moves()
	
func show_pokemon_moves():
	var size = len(PlayerData.player_test["Pokedex"][number]["Movements"])
	if size == 1:
		move1.visible = true
	elif size == 2:
		move1.visible = true
		move2.visible = true
	elif size == 3:
		move1.visible = true
		move2.visible = true
		move3.visible = true
	else:
		move1.visible = true
		move2.visible = true
		move3.visible = true
		move4.visible = true
	name_moves(size)

func name_moves(moves):
	if moves >= 1:
		var max_pp = PlayerData.get_max_movement_pp(PlayerData.player_test["Pokedex"][number]["Movements"][0])
		print ("IM ENTERING")
		move1.get_node("Sprite").frame = show_type(PlayerData.player_test["Pokedex"][number]["Movements"][0]["type"])
		move1.get_node("name").text = PlayerData.player_test["Pokedex"][number]["Movements"][0]["ename"]
		move1.get_node("pp").text = "PP %s" % String(PlayerData.player_test["Pokedex"][number]["Movements"][0]["pp"]) + " / %s" % max_pp
		if moves >= 2:
			var max_pp1 = PlayerData.get_max_movement_pp(PlayerData.player_test["Pokedex"][number]["Movements"][1])
			move2.get_node("Sprite").frame = show_type(PlayerData.player_test["Pokedex"][number]["Movements"][1]["type"])
			move2.get_node("Sprite").frame = show_type(PlayerData.player_test["Pokedex"][number]["Movements"][1]["type"])
			move2.get_node("name").text = PlayerData.player_test["Pokedex"][number]["Movements"][1]["ename"]
			move2.get_node("pp").text = "PP %s" % String(PlayerData.player_test["Pokedex"][number]["Movements"][1]["pp"]) + " / %s" % max_pp1
			if moves >= 3:
				var max_pp2 = PlayerData.get_max_movement_pp(PlayerData.player_test["Pokedex"][number]["Movements"][2])
				move3.get_node("Sprite").frame = show_type(PlayerData.player_test["Pokedex"][number]["Movements"][2]["type"])
				move3.get_node("name").text = PlayerData.player_test["Pokedex"][number]["Movements"][2]["ename"]
				move3.get_node("pp").text = "PP %s" % String(PlayerData.player_test["Pokedex"][number]["Movements"][2]["pp"]) + " / %s" % max_pp2
				if moves >= 4:
					var max_pp3 = PlayerData.get_max_movement_pp(PlayerData.player_test["Pokedex"][number]["Movements"][3])
					move4.get_node("Sprite").frame = show_type(PlayerData.player_test["Pokedex"][number]["Movements"][3]["type"])
					move4.get_node("name").text = PlayerData.player_test["Pokedex"][number]["Movements"][3]["ename"]
					move4.get_node("pp").text = "PP %s" % String(PlayerData.player_test["Pokedex"][number]["Movements"][3]["pp"]) + " / %s" % max_pp3


func show_type(type)->int:
	var frame = 0
	if type == "Normal":
		frame = 0
	elif type == "Fighting":
		frame = 1
	elif type == "Flying":
		frame = 2
	elif type == "Poison":
		frame = 3
	elif type == "Ground":
		frame = 4
	elif type == "Rock":
		frame = 5
	elif type == "Bug":
		frame = 6
	elif type == "Ghost":
		frame = 7
	elif type == "Steel":
		frame = 8
	elif type == "Fire":
		frame = 9
	elif type == "Water":
		frame = 10
	elif type == "Grass":
		frame = 11
	elif type == "Electric":
		frame = 12
	elif type == "Psychic":
		frame = 13
	elif type == "Ice":
		frame = 14
	elif type == "Dragon":
		frame = 15
	elif type == "Dark":
		frame = 16
	else:
		frame = 17
	return (frame)

var to_show_pokemon = []
func maximum()-> int:
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x = x+1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
		if PlayerData.player_test["Pokedex"][x]["In_PC"] == null:
			to_show_pokemon.append(x)
	return (maximum)
	
func translate(value:int,string) -> int:
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["In_PC"] == null:
			to_show_pokemon.append(x)
	for x in range(len(to_show_pokemon)):
		if value == to_show_pokemon[x]:
			pass
		else:
			if string == "up":
				value += 1
			if string == "down":  #HACIA LA IZQUIERDA NO FUNCIONA
				value -= 1
	if value>=len(PlayerData.player_test["Pokedex"]) and string == "up":
		value = to_show_pokemon.min()
	elif value<0 and string == "down":
		value = to_show_pokemon.max()
	return (value)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("right"):
		PlayerData.pokemon_selected = translate(number+1,"up")
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_movements.tscn")
	elif Input.is_action_pressed("left"):
		PlayerData.pokemon_selected = translate(number-1,"down")
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_movements.tscn")
	elif Input.is_action_pressed("down"):
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page.tscn")
	elif Input.is_action_pressed("up"):
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_attacks.tscn")


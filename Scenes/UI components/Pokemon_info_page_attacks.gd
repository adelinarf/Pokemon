extends Control

onready var upper = get_node("GridContainer2/Label2")
onready var number = PlayerData.pokemon_selected
onready var Attack = get_node("GridContainer4/fill")
onready var Defense = get_node("GridContainer4/fill2")
onready var Special_attack = get_node("GridContainer4/fill3")
onready var Special_defense = get_node("GridContainer4/fill4")
onready var Velocity = get_node("GridContainer4/fill5")
onready var Experience = get_node("GridContainer5/experiencevalue")
onready var Next_experience = get_node("GridContainer5/experience_next")
onready var found_at = get_node("GridContainer5/Label")
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
	$nickname.text = PlayerData.player_test["Pokedex"][number]["Nickname"]
	$hp.text = String(PlayerData.player_test["Pokedex"][number]["HP"])
	upper.text = "Level %s" % PlayerData.player_test["Pokedex"][number]["Level"] 
	Attack.text = String(base["Attack"])
	Defense.text = String(base["Defense"])
	Special_attack.text = String(base["Sp. Attack"])
	Special_defense.text = String(base["Sp. Defense"])
	Velocity.text = String(base["Speed"])
	var info = PlayerData.get_pokemon_info_by_name(poke_name)
	Experience.text = String(PlayerData.player_test["Pokedex"][number]["Experience"])
	Next_experience.text = calculate_experience_points()

func calculate_experience_points()->String:
	var current_experience = PlayerData.player_test["Pokedex"][number]["Experience"]
	var next_level = PlayerData.player_test["Pokedex"][number]["Level"] + 1
	var next_experience = (int(floor(4*pow(next_level,3) / 5)))
	var output = String(next_experience - current_experience)
	return (output)
	
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
	print (to_show_pokemon.min(),"LA MAS CHIQUI")
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
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_attacks.tscn")
	elif Input.is_action_pressed("left"):
		PlayerData.pokemon_selected = translate(number-1,"down")
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_attacks.tscn")
	elif Input.is_action_pressed("down"):
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_movements.tscn")
	elif Input.is_action_pressed("up"):
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page.tscn")


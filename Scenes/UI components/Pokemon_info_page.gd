extends Control

onready var upper = get_node("GridContainer2/Label2")
onready var Number = get_node("GridContainer/fill")
onready var Name = get_node("GridContainer/fill2")
onready var Type = get_node("GridContainer/fill3")
onready var EO = get_node("GridContainer/fill4")
onready var ID = get_node("GridContainer/fill5")
onready var Objects = get_node("GridContainer/fill6")
onready var number = PlayerData.pokemon_selected
onready var poke_sprite = get_node("Sprite")
onready var found_at = get_node("GridContainer5/Label")
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
	Number.text = String(id)
	Type.text = "  "
	if len(type)==1:
		$type.frame=show_type(type[0])
		$type2.visible=false
	else:
		$type.frame=show_type(type[0])
		$type2.frame=show_type(type[1])
	Name.text = poke_name
	EO.text = PlayerData.player_test["name"]
	ID.text = String(PlayerData.player_test["Pokedex"][number]["Id number"])
	if PlayerData.player_test["Pokedex"][number]["Objects"] == null:
		Objects.text = "There's no objects"
	else:
		Objects.text = PlayerData.player_test["Pokedex"][number]["Objects"]
	upper.text = "Level %s" % PlayerData.player_test["Pokedex"][number]["Level"]
	found_at.text = "ANYWHERE"

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
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page.tscn")
	elif Input.is_action_pressed("left"):
		PlayerData.pokemon_selected = translate(number-1,"down")
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page.tscn")
	elif Input.is_action_pressed("down"):
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_attacks.tscn")
	elif Input.is_action_pressed("up"):
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_page_movements.tscn")

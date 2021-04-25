extends Control
var pokeballs = PlayerData.player_test["Bag"][0]
var key_objects = PlayerData.player_test["Bag"][1]
var objects = PlayerData.player_test["Bag"][2]
var habitat = "Grassland"
var dictionary_habitat = {"Grassland":3,"Forest":0,"Water's edge":10,"Sea":9,"Cave":7,"Mountain":4,"Rough-terrain":5,"Urban":1,"Rare":13}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_bag_objects(habitat)

var pokemon_in_pc_id = []
func add_item():
	for i in range(len(PlayerData.player_test["Pokedex"])):
		if habitat == PlayerData.player_test["Pokedex"][i]["Habitat"] and PlayerData.player_test["Pokedex"][i]["In_PC"] == true:
			$ItemList.add_item(String(PlayerData.player_test["Pokedex"][i]["name"]))
			pokemon_in_pc_id.append(PlayerData.player_test["Pokedex"][i]["Id number"])

func show_bag_objects(habitat:String):
	$ItemList2.visible = false
	$ItemList3.visible = false
	$ItemList.clear()
	$Label.text = habitat
	$Box_background.frame = dictionary_habitat[habitat]
	add_item()

var pokemon_selected = null
	
func _on_ItemList_item_selected(index: int) -> void:
	var name = $ItemList.get_item_text(index)
	pokemon_selected = name
	fill_info(pokemon_selected)
	$ItemList2.clear()
	$ItemList2.visible = true
	$ItemList2.add_item("Move")
	$ItemList2.add_item("Exit")

func fill_info(name):
	$pokemon_info.visible = true
	var selected_id = null
	var position = null
	for x in range(len(PlayerData.player_test["Pokedex"])):
		for id in pokemon_in_pc_id:
			if PlayerData.player_test["Pokedex"][x]["Id number"] == id:
				selected_id = id
				position = x
	var nick = PlayerData.player_test["Pokedex"][position]["Nickname"]
	var level = PlayerData.player_test["Pokedex"][position]["Level"]
	$pokemon_info/Label.text = nick + " / " + name + " \n \n" + "Level: "+ String(level)
	

func _on_Button_pressed() -> void:
	if habitat == "Grassland":
		habitat = "Forest"
	elif habitat == "Forest":
		habitat = "Water's edge"
	elif habitat == "Water's edge":
		habitat = "Sea"
	elif habitat == "Sea":
		habitat = "Cave"
	elif habitat == "Cave":
		habitat = "Mountain"
	elif habitat == "Mountain":
		habitat = "Rough-terrain"
	elif habitat == "Rough-terrain":
		habitat = "Urban"
	elif habitat == "Urban":
		habitat = "Rare"
	else: 
		habitat = "Grassland"
	show_bag_objects(habitat)	


var pokemon_can_fight_id = [null,null,null,null]
func get_pokemon_()-> Array:
	var pokemon = [null,null,null,null]
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
			pokemon[0]=x
			pokemon_can_fight_id[0]=PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 1:
			pokemon[1]=x
			pokemon_can_fight_id[1]=PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
			pokemon[2]=x
			pokemon_can_fight_id[2]=PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 3:
			pokemon[3]=x
			pokemon_can_fight_id[3]=PlayerData.player_test["Pokedex"][x]["Id number"]
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x=x+1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
	pokemon_can_fight_id.slice(0,maximum)
	var lists = [pokemon,maximum]
	return (lists)
	
func select_pokemon():
	$ItemList3.visible = true
	var lists = get_pokemon_()
	var pokemon = lists[0]
	var maximum = lists[1]
	var pokemon_ = pokemon.slice(0,maximum)
	if maximum >= 4:
		for x in range(len(pokemon_)):
			$ItemList3.add_item(PlayerData.player_test["Pokedex"][pokemon_[x]]["name"])
		$ItemList3.add_item("Exit")
	else:
		var position = null
		for x in range(len(PlayerData.player_test["Pokedex"])):
			for id in pokemon_in_pc_id:
				if PlayerData.player_test["Pokedex"][x]["Id number"] == id:
					position = x
		PlayerData.player_test["Pokedex"][position]["Order_in_fight"] = maximum + 1
		PlayerData.player_test["Pokedex"][position]["In_PC"] = null
	
func _on_ItemList2_item_selected(index: int) -> void:
	var name = $ItemList2.get_item_text(index)
	print (name)
	if name == "Exit":
		$ItemList2.visible = false
	if name == "Move":
		$ItemList3.clear()
		select_pokemon()
		show_bag_objects(habitat)

func _on_ItemList3_item_selected(index: int) -> void:
	var name = $ItemList3.get_item_text(index)
	if name == "Exit":
		$ItemList3.visible = false
	if name != "Exit":
		change_pokemon(name)
		show_bag_objects(habitat)	

func find_pokemon_position(name,string)->int:
	var position = null
	if string == "fighter":
		for x in range(len(PlayerData.player_test["Pokedex"])):
			for i in range(len(pokemon_can_fight_id)):
				if PlayerData.player_test["Pokedex"][x]["name"] == name and PlayerData.player_test["Pokedex"][x]["Id number"] == pokemon_can_fight_id[i]:
					position = x
	elif string == "boxed":
		for x in range(len(PlayerData.player_test["Pokedex"])):
			for i in range(len(pokemon_in_pc_id)):
				if PlayerData.player_test["Pokedex"][x]["name"] == name and PlayerData.player_test["Pokedex"][x]["Id number"] == pokemon_in_pc_id[i]:
					position = x
	return (position)
	
func change_pokemon(name):
	var pokemon_in_box = find_pokemon_position(pokemon_selected,"boxed")
	var pokemon_to_change = find_pokemon_position(name,"fighter")
	PlayerData.player_test["Pokedex"][pokemon_in_box]["Order_in_fight"] = PlayerData.player_test["Pokedex"][pokemon_to_change]["Order_in_fight"]
	PlayerData.player_test["Pokedex"][pokemon_to_change]["Order_in_fight"] = null
	PlayerData.player_test["Pokedex"][pokemon_in_box]["In_PC"] = null
	PlayerData.player_test["Pokedex"][pokemon_to_change]["In_PC"] = true

func _on_Party_pressed() -> void:
	$TextureRect.visible = not $TextureRect.visible
	$Pokemon_in_bag.visible = not $Pokemon_in_bag.visible
	

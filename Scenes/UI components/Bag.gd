extends Control

var pokeballs = PlayerData.player_test["Bag"][0]
var key_objects = PlayerData.player_test["Bag"][1]
var objects = PlayerData.player_test["Bag"][2]
var pokeballs_items = true
var key_items = false
var items = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_bag_objects()
	if PlayerData.player_test["Sprite"] == 0:
		$background.frame = 0
	elif PlayerData.player_test["Sprite"] == 1:
		$background.frame = 1

func add_item(x : int):
	for i in range(len(PlayerData.player_test["Bag"][x]["Content"])):
		$ItemList.add_item(String(PlayerData.player_test["Bag"][x]["Content"][i][0]))
	

func show_bag_objects():
	$ItemList2.visible = false
	$ItemList3.visible = false
	$ItemList.clear()
	if pokeballs_items == true:
		$labels.frame = 2
		add_item(0)
	elif key_items == true:
		$labels.frame = 1
		add_item(1)
	else:
		$labels.frame = 0
		add_item(2)

var object_selected = null
	
func _on_ItemList_item_selected(index: int) -> void:
	var name = $ItemList.get_item_text(index)
	object_selected = name
	$ItemList2.clear()
	$ItemList2.visible = true
	if pokeballs_items == true:
		$ItemList2.add_item("Give")
		$ItemList2.add_item("Throw")
		$ItemList2.add_item("Exit")
	elif key_items == true:
		$ItemList2.add_item("Use")
		$ItemList2.add_item("Asign")
		$ItemList2.add_item("Exit")
	elif items == true:
		$ItemList2.add_item("Use")
		$ItemList2.add_item("Give")
		$ItemList2.add_item("Throw")
		$ItemList2.add_item("Exit")
	else:
		pass

func _on_Button_pressed() -> void:
	if pokeballs_items == true:
		pokeballs_items = false
		key_items = true
		items = false
	elif key_items == true:
		pokeballs_items = false
		key_items = false
		items = true
	elif items == true:
		items = false
		pokeballs_items = true
		key_items = false
	show_bag_objects()	

func get_pokemon_()-> Array:
	var pokemon = [null,null,null,null]
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
			pokemon[0]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 1:
			pokemon[1]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
			pokemon[2]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 3:
			pokemon[3]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x+=1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
	var lists = [pokemon,maximum]
	return (lists)

var added_pokemon_ = [null,null,null,null]
func select_pokemon():
	$ItemList3.visible = true
	var lists = get_pokemon_()
	var pokemon = lists[0]
	var maximum = lists[1]
	var pokemon_ = pokemon.slice(0,maximum)
	for x in range(len(pokemon_)):
		$ItemList3.add_item(PlayerData.player_test["Pokedex"][pokemon_[x]]["name"])
		added_pokemon_[x] = PlayerData.player_test["Pokedex"][pokemon_[x]]["Id number"]
	$ItemList3.add_item("Exit")
	
func _on_ItemList2_item_selected(index: int) -> void:
	var name = $ItemList2.get_item_text(index)
	print (name)
	if name == "Exit":
		$ItemList2.visible = false
	if pokeballs_items == true and PlayerData.player_test["Fighting"] == true and name == "Throw":
		for i in range (len(PlayerData.player_test["Bag"][0]["Content"])):
			if PlayerData.player_test["Bag"][0]["Content"][i][0] == object_selected:
				PlayerData.player_test["Bag"][0]["Content"][i][1] -= 1
	if name == "Give":
		$ItemList3.clear()
		select_pokemon()
		#get_tree().change_scene("res://Scenes/UI components/Select_pokemon.tscn")
	if name == "Throw" and pokeballs_items == false:
		eliminate_item()
	if name == "Throw" and pokeballs_items == true and PlayerData.player_test["Fighting"] == true:
		eliminate_item()
		PlayerData.catching_pokemon = true
		get_tree().change_scene("res://Scenes/Battle_.tscn")
	
func eliminate_item():
	for x in range(len(PlayerData.player_test["Bag"])):
		for i in range (len(PlayerData.player_test["Bag"][x]["Content"])):
			if PlayerData.player_test["Bag"][x]["Content"][i][0] == object_selected:
				PlayerData.player_test["Bag"][x]["Content"][i][1] = PlayerData.player_test["Bag"][x]["Content"][i][1] - 1

func get_pokemon_by_name(value :String)->Array:
	var number = null
	var id = null
	var nick = null
	var lists = get_pokemon_()
	var pokemon_ = lists[0]
	var maximum = lists[1]
	added_pokemon_ = added_pokemon_.slice(0,maximum)
	pokemon_ = pokemon_.slice(0,maximum)
	for x in range(len(pokemon_)):
		for i in range(len(added_pokemon_)):
			if PlayerData.player_test["Pokedex"][pokemon_[x]]["name"] == value and PlayerData.player_test["Pokedex"][pokemon_[x]]["Id number"] == added_pokemon_[i]:
				number = pokemon_[x]
				id = PlayerData.player_test["Pokedex"][pokemon_[x]]["Id number"]
				nick = PlayerData.player_test["Pokedex"][pokemon_[x]]["Nickname"]
			else:
				pass
	return ([number,id,nick])

func _on_ItemList3_item_selected(index: int) -> void:
	var name = $ItemList3.get_item_text(index)
	var arr = get_pokemon_by_name(name)
	var number_name = arr[0]
	var id = arr[1]
	var nickname = arr[2]
	if name == "Exit":
		$ItemList3.visible = false
	if name != "Exit":	
		if PlayerData.player_test["Pokedex"][number_name]["Objects"] == null:
			PlayerData.player_test["Pokedex"][number_name]["Objects"]=object_selected
			eliminate_item()
		else:
			$Label2.visible = true
			$Label2.text = "%s has already a" % name + "'" + nickname + "'" + " %s " % String(PlayerData.player_test["Pokedex"][number_name]["Objects"])


func _on_Exit_pressed():
	if PlayerData.player_test["Fighting"]==true:
		get_tree().change_scene("res://Scenes/Battle_.tscn")
	elif PlayerData.player_test["Fighting"]==false:
		get_tree().change_scene(PlayerData.is_in[1])

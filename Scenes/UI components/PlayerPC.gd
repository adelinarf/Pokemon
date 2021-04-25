extends Control

var pokeballs = PlayerData.player_test["PC_Objects"][0]
var key_objects = PlayerData.player_test["PC_Objects"][1]
var objects = PlayerData.player_test["PC_Objects"][2]
var pokeballs_items = true
var key_items = false
var items = false

# $ItemList.clear()
			#$ItemList.add_item(PlayerData.player_test["Pokedex"][x]["name"])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_bag_objects()

func add_item(x : int):
	for i in range(len(PlayerData.player_test["PC_Objects"][x]["Content"])):
		$ItemList.add_item(String(PlayerData.player_test["PC_Objects"][x]["Content"][i][0]))
	

func show_bag_objects():
	$ItemList2.visible = false
	$ItemList3.visible = false
	$ItemList.clear()
	if pokeballs_items == true:
		$Label.text = "Pokeballs"
		add_item(0)
	elif key_items == true:
		$Label.text = "Key Items"
		add_item(1)
	else:
		$Label.text = "Items"
		add_item(2)

var object_selected = null
	
func _on_ItemList_item_selected(index: int) -> void:
	var name = $ItemList.get_item_text(index)
	object_selected = name
	$ItemList2.clear()
	$ItemList2.visible = true
	$ItemList2.add_item("Move to bag")
	$ItemList2.add_item("Exit")

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
	
func _on_ItemList2_item_selected(index: int) -> void:
	var name = $ItemList2.get_item_text(index)
	print (name)
	if name == "Exit":
		$ItemList2.visible = false
	if name == "Move to bag":
		move_to_bag()
		show_bag_objects()

func move_to_bag():
	var x = null
	if pokeballs_items == true:
		x = 0
	elif key_items == true:
		x = 1
	elif items == true:
		x = 2
	var position = null
	for i in range(len(PlayerData.player_test["Bag"][x]["Content"])):
		if PlayerData.player_test["PC_Objects"][x]["Content"][i][0] == object_selected:
			position = i
	for i in range (len(PlayerData.player_test["Bag"][x]["Content"])):
		if PlayerData.player_test["Bag"][x]["Content"][i][0] == object_selected:
			PlayerData.player_test["Bag"][x]["Content"][i][1] = PlayerData.player_test["Bag"][x]["Content"][i][1] + 1
		else:
			PlayerData.player_test["Bag"][x]["Content"].append([object_selected,1])

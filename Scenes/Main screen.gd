extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$Label.text = ""
	var info = PlayerData.load_game(-1)
	for x in range(len(info)):
		var a = info[x]["player_info"]["name"] + String(info[x]["Time saved"])
		$Label.text += a +"\n"
		$ItemList.add_item(a)
	#for x in range(len(info)):
		#var TO = info[x]["player_info"]["id"] + info[x]["player_info"]["name"] + info[x]["Time saved"]
		#$Label.text += String(TO) + "\n"


func _on_ItemList_item_selected(index):
	var selected = index
	PlayerData.load_game(selected)
	get_tree().change_scene(PlayerData.is_in[1])
	


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Start_game2ndtry.tscn")

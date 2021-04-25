extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
	PlayerData.is_in[0] = "SaffronCity"
	PlayerData.is_in[1] = "res://Scenes/World/Saffron City.tscn"
	PlayerData.colliding_character="Guard"
	var flute = has_flute()
	if flute==true:
		$Guard.number_of_character_in_dialogue = "Silph Co Guard after"
		$Guard.position = Vector2(1394.553,642.352)
	elif flute==false:
		pass
	if PlayerData.defeated_team_rocket==false:
		pass
	elif PlayerData.defeated_team_rocket==true:
		$"1".number_of_character_in_dialogue+=" after"
		$"2".number_of_character_in_dialogue+=" after"
		$"3".number_of_character_in_dialogue+=" after"
		$"4".number_of_character_in_dialogue+=" after"
		$"5".number_of_character_in_dialogue+=" after"
		$"6".number_of_character_in_dialogue+=" after"
		$"7".number_of_character_in_dialogue+=" after"

func has_flute()->bool:
	var has_flute=false
	for x in range(len(PlayerData.player_test["Bag"][1]["Content"])):
		if PlayerData.player_test["Bag"][1]["Content"][x][0]=="Flute":
			has_flute=true
		else:
			has_flute=false
	return (has_flute)

func _on_Saffron_City_tree_exiting():
	PlayerData.is_in[2]=$player.position
	print (PlayerData.is_in[2])


func _on_Tunnel1_area_entered(area):
	get_tree().change_scene("res://Scenes/World/Tunnel.tscn")

func _on_Tunnel2_area_entered(area):
	get_tree().change_scene("res://Scenes/World/Tunnel.tscn")
	
func _on_Tunnel3_area_entered(area):
	get_tree().change_scene("res://Scenes/World/Tunnel.tscn")

func _on_Tunnel4_area_entered(area):
	get_tree().change_scene("res://Scenes/World/Tunnel.tscn")

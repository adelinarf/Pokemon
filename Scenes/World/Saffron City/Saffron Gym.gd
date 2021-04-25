extends Node2D


var saffron_city = load("res://Scenes/World/Saffron City.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
	PlayerData.is_in[0] = "SaffronCity"
	PlayerData.is_in[1] = "res://Scenes/World/Saffron City/Saffron Gym.tscn"
	$Door.next_scene = saffron_city
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($Sabrina)
	if PlayerData.player_test["Medals"]["MARSHBADGE"]==true:
		$NPC1.number_of_character_in_dialogue+=" after"
	elif PlayerData.player_test["Medals"]["MARSHBADGE"]==false:
		pass


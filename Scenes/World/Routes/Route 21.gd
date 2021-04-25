extends Node2D

var cinnabar_island = load("res://Scenes/World/Cinnabar Island.tscn")
var pallet_town = load("res://Scenes/World/Pallet Town.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route21
	PlayerData.is_in[0] = "Route21"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 21.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"Trainer 8")
	PlayerData.show_right_dialogue($"Trainer 9")


func _on_to_cinnabar_island_area_entered(area):
	get_tree().change_scene_to(cinnabar_island)

func _on_to_pallet_town_area_entered(area):
	get_tree().change_scene_to(pallet_town)

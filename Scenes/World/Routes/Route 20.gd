extends Node2D

var route19 = load("res://Scenes/World/Routes/Route 19.tscn")
var cinnabar_island = load("res://Scenes/World/Cinnabar Island.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route20
	PlayerData.is_in[0] = "Route20"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 20.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")


func _on_to_route19_area_entered(area):
	get_tree().change_scene_to(route19)

func _on_to_cinnabar_island_area_entered(area):
	get_tree().change_scene_to(cinnabar_island)

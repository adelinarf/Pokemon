extends Node2D

var route20=preload("res://Scenes/World/Routes/Route 20.tscn")
var fuchsia_city = load("res://Scenes/World/Fuchsia City.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route19
	PlayerData.is_in[0] = "Route19"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 19.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"Trainer 8")
	PlayerData.show_right_dialogue($"Trainer 9")
	PlayerData.show_right_dialogue($"Trainer 10")


func _on_to_route20_area_entered(area):
	get_tree().change_scene_to(route20)
	
func _on_to_fuchsia_city_area_entered(area):
	get_tree().change_scene_to(fuchsia_city)

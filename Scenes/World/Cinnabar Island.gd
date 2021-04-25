extends Node2D


var route20 = load("res://Scenes/World/Routes/Route 20.tscn")
var route21 =preload("res://Scenes/World/Routes/Route 21.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.cinnabar_island
	PlayerData.is_in[0] = "CinnabarIsland"
	PlayerData.is_in[1] = "res://Scenes/World/Cinnabar Island.tscn"


func _on_to_route20_area_entered(area):
	get_tree().change_scene_to(route20)

func _on_to_route21_area_entered(area):
	get_tree().change_scene_to(route21)

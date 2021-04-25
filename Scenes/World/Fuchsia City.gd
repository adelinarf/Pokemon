extends Node2D


var route19 = load("res://Scenes/World/Routes/Route 19.tscn")
var tunnel = load("res://Scenes/World/Tunnel.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.fuchsia_city
	PlayerData.is_in[0] = "FuchsiaCity"
	PlayerData.is_in[1] = "res://Scenes/World/Fuchsia City.tscn"


func _on_to_tunnel_area_entered(area):
	get_tree().change_scene_to(tunnel)

func _on_to_tunnel2_area_entered(area):
	get_tree().change_scene_to(tunnel)

func _on_to_route19_area_entered(area):
	get_tree().change_scene_to(route19)

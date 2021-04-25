extends Node2D

var tunnel = load("res://Scenes/World/Tunnel.tscn")
var cycling_road = preload("res://Scenes/World/Routes/Route 17.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route18
	PlayerData.is_in[0] = "Route18"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 18.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")

func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_to_tunnel_area_entered(area):
	get_tree().change_scene_to(tunnel)
	
func _on_to_cycling_road_area_entered(area):
	get_tree().change_scene_to(cycling_road)

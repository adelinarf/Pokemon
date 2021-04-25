extends Node2D


var lavender_town = load("res://Scenes/World/Lavender Town.tscn")
var route11 = load("res://Scenes/World/Routes/Route 11.tscn")
var route13 = preload("res://Scenes/World/Routes/Route 13.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route12
	PlayerData.is_in[0] = "Route12"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 12.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"2")
	PlayerData.show_right_dialogue($"3")

func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_to_lavender_town_area_entered(area):
	get_tree().change_scene_to(lavender_town)

func _on_to_route11_area_entered(area):
	get_tree().change_scene_to(route11)

func _on_to_route13_area_entered(area):
	get_tree().change_scene_to(route13)

extends Node2D

var route18 = load("res://Scenes/World/Routes/Route 18.tscn")
var route16 = load("res://Scenes/World/Routes/Route 16.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route17
	PlayerData.is_in[0] = "Route17"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 17.tscn"
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

func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")


func _on_to_route18_area_entered(area):
	get_tree().change_scene_to(route18)

func _on_to_route16_area_entered(area):
	get_tree().change_scene_to(route16)

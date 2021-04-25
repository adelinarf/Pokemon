extends Node2D

onready var route2=load("res://Scenes/World/Routes/Route 2.tscn")
onready var pewter_city = preload("res://Scenes/World/Pewter City.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route2
	PlayerData.is_in[0] = "ViridianForest"
	PlayerData.is_in[1] = "res://Scenes/World/Viridian Forest.tscn"
	PlayerData.show_right_dialogue($trainer1)
	PlayerData.show_right_dialogue($trainer2)
	PlayerData.show_right_dialogue($trainer3)

func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_to_route2_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(route2)

func _on_to_pewter_city_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(pewter_city)

extends Node2D


onready var to_tunnel = load("res://Scenes/World/Tunnel.tscn")
onready var to_underground_path = load("res://Scenes/World/Underground Path.tscn")
onready var vermilion_city = preload("res://Scenes/World/Vermilion City.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route6
	PlayerData.is_in[0]="Route6"
	PlayerData.is_in[1]="res://Scenes/World/Routes/Route 6.tscn"
	PlayerData.colliding_character="Trainer 1"
	$Underground_path.next_scene = to_underground_path
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	
func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")


func _on_to_vermilion_city_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(vermilion_city)

func _on_to_saffron_city_area_entered(area):
	get_tree().change_scene_to(to_tunnel)

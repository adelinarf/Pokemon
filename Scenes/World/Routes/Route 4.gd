extends Node2D


var route3 = load("res://Scenes/World/Routes/Route 3.tscn")
var mt_moon = preload("res://Scenes/World/Mountain Moon.tscn")
var mt_moon_exit = load("res://Scenes/World/Mountain Moon 3.tscn")
var pokemon_center = load("res://Scenes/World/Viridian City/Pokemon Center.tscn")
var cerulean_city = preload("res://Scenes/World/Cerulean City.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	#$player.position = PlayerData.find_player_pos()
	PlayerData.current_dialogue = PlayerData.dialogue.route3
	PlayerData.current_dialogue = PlayerData.dialogue.mt_moon
	PlayerData.is_in[0]="Route3"
	PlayerData.is_in[1]="res://Scenes/World/Routes/Route 4.tscn"
	PlayerData.is_in[2]=Vector2(1,1)
	$cave_entrance.next_scene=mt_moon
	$cave_exit.next_scene=mt_moon_exit
	$DoorCenter.next_scene = pokemon_center
	
func _on_to_route3_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(route3)
		
func _on_player_body_entered(body: Node) -> void:
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_to_cerulean_city_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(cerulean_city)

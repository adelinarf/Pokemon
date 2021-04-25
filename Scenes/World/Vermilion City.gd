extends Node2D


onready var route6 = load("res://Scenes/World/Routes/Route 6.tscn")
onready var SSAnne = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Entrance.tscn")
onready var route11 = preload("res://Scenes/World/Routes/Route 11.tscn")
onready var fan_club = preload("res://Scenes/World/Vermillion City/Fan Club.tscn")
onready var gym = preload("res://Scenes/World/Vermillion City/Vermilion Gym.tscn")
onready var house = load("res://Scenes/World/Cerulean City/House.tscn")
onready var pokemon_center = load("res://Scenes/World/Viridian City/Pokemon Center.tscn")
onready var mart = load("res://Scenes/World/Viridian City/Mall.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermilion City.tscn"
	PlayerData.colliding_character="1"
	$"Gym door".next_scene = gym
	$"Club door".next_scene = fan_club
	for x in range(len(PlayerData.player_test["Bag"][1]["Content"])):
		if PlayerData.player_test["Bag"][1]["Content"][x][0]=="Ticket":
			$not_able_to_cross.collision_layer = 1
		else:
			$not_able_to_cross.collision_layer = 2
	$SSANNE/AnimationPlayer.stop()
	$Door.next_scene = house
	$DoorCenter.next_scene = pokemon_center
	$DoorMall.next_scene = mart
	$Door2.next_scene = house
	$Door3.next_scene = house
	var a = has_cut()
	if a==true:
		print ("has cut")
		$"Entrance SS Anne".number_of_character_in_dialogue = "2 after"
		$"Entrance SS Anne".advice_character=false
		$"Entrance SS Anne".regular_character=true
		PlayerData.colliding_character="2 after"
	else:
		pass
		
func has_cut()->bool:
	var has_move=false
	for x in range(len(PlayerData.player_test["Bag"][2]["Content"])):
		if PlayerData.player_test["Bag"][2]["Content"][x][0]=="CUT":
			has_move = true
		else:
			has_move=false
	return (has_move)

	
func _on_to_route6_area_entered(area):
	get_tree().change_scene_to(route6)


func _on_SS_Anne_area_entered(area):
	get_tree().change_scene_to(SSAnne)


func _on_not_able_to_cross_area_entered(area):
	var a = has_cut()
	if a==true:
		$player.stop_moving = true
		$SSANNE/AnimationPlayer.play("sail away")
		PlayerData.colliding_character = "2 after"
		PlayerData.is_colliding_with=4
	elif a==false:
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="sail away":
		$player.stop_moving = false

func _on_to_route11_area_entered(area):
	get_tree().change_scene_to(route11)

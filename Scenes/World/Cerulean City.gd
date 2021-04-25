extends Node2D

onready var route24 = preload("res://Scenes/World/Routes/Route 24.tscn")
onready var route4 = load("res://Scenes/World/Routes/Route 4.tscn")
onready var route5 = preload("res://Scenes/World/Routes/Route 5.tscn")
onready var route9 = preload("res://Scenes/World/Routes/Route 9.tscn")
onready var robbed_house = preload("res://Scenes/World/Cerulean City/House_Wrecked.tscn")
onready var house2 = load("res://Scenes/World/Cerulean City/House2.tscn")
onready var house3 = load("res://Scenes/World/Cerulean City/House3.tscn")
onready var house = load("res://Scenes/World/Cerulean City/House.tscn")
onready var pokemon_center = load("res://Scenes/World/Viridian City/Pokemon Center.tscn")
onready var mart = load("res://Scenes/UI components/Mall.tscn")
onready var gym = load("res://Scenes/World/Cerulean City/Cerulean Gym.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.cerulean_city
	PlayerData.is_in[0]="CeruleanCity"
	PlayerData.is_in[1]="res://Scenes/World/Cerulean City.tscn"
	if PlayerData.player_test["Medals"]["CASCADEBADGE"]==true:
		$Cop.position = Vector2(1184.185,-134.263)
		$wrecked_house.next_scene = robbed_house
	else:
		$wrecked_house.next_scene = PlayerData.is_in[1]
	if PlayerData.first_time_cerulean==true:
		$try_exit.collision_layer=2
	else:
		$try_exit.collision_layer=1
	$Door1.next_scene = house2
	$Door2.next_scene = house3
	$Door3.next_scene = house
	$DoorCenter.next_scene = pokemon_center
	$DoorGym.next_scene = gym
	$Door4.next_scene = house
	$DoorMall.next_scene = mart
	PlayerData.show_right_dialogue($Rocket)
	var a = has_tm()
	if a == true:
		$Rocket.free()
	elif a==false:
		pass
	print(PlayerData.player_test["Bag"][2]["Content"])
	
func _on_try_exit_area_entered(area):
	if area.is_in_group("player"):
		if PlayerData.first_time_cerulean==true:
			$Rival/AnimationPlayer.play("walk")
			#$player._on_player_area_entered($Rival)
			$player.stop_moving = true
			PlayerData.colliding_character = "Rival_Fight"
			PlayerData.is_colliding_with=2
			PlayerData.first_time_cerulean=false
		else:
			pass

func _on_Cerulean_City_tree_exiting():
	$player.stop_moving = false
	PlayerData.colliding_character="Trainer 1"


func _on_to_route24_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(route24)

func _on_ro_route4_area_entered(area):
	get_tree().change_scene_to(route4)

func _on_to_route5_area_entered(area):
	get_tree().change_scene_to(route5)

func _on_ro_route9_area_entered(area):
	get_tree().change_scene_to(route9)


func has_tm()->bool:
	var has_tm = false
	for x in range(len(PlayerData.player_test["Bag"][2]["Content"])):
		if PlayerData.player_test["Bag"][2]["Content"][x][0]=="TM28":
			has_tm = true
		else:
			has_tm = false
	return (has_tm)


func _on_player_colliding(value):
	var a = has_tm()
	if value == true and PlayerData.colliding_character== "Trainer 1 after" and a==false:
		PlayerData.player_test["Bag"][2]["Content"].append(["TM28",1])
		$Rocket/AnimationPlayer.play("walkrocket")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "walkrocket":
		$Rocket/AnimationPlayer.stop()
		$Rocket.visible=false
		$Rocket.collision_layer=1

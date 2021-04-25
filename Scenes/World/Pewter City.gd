extends Node2D

var pos_npc_museum = Vector2.ZERO
var pos_npc_gym = Vector2.ZERO
var house1 = load("res://Scenes/World/Viridian City/house1.tscn")
var house2 = load("res://Scenes/World/Viridian City/house1.tscn")
var museum_main = preload("res://Scenes/World/Pewter City/Museum 1st floor.tscn")
var museum_second_entrance = preload("res://Scenes/World/Pewter City/Museum 1st floor.tscn")
var mart = load("res://Scenes/World/Viridian City/Mall.tscn")
var pokemon_center = load("res://Scenes/World/Viridian City/Pokemon Center.tscn")
var pewter_gym = preload("res://Scenes/World/Pewter City/First Gym.tscn")
var viridian_forest = load("res://Scenes/World/Viridian Forest.tscn")
var route3 = preload("res://Scenes/World/Routes/Route 3.tscn")
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.pewter_city
	PlayerData.is_in[0]="PewterCity"
	PlayerData.is_in[1]="res://Scenes/World/Pewter City.tscn"
	PlayerData.colliding_character="1"
	$NPC_museum/AnimationPlayer.stop()
	pos_npc_gym=$NPC_gym.position
	pos_npc_museum=$NPC_museum.position
	$house1door.next_scene=house1
	$house2door.next_scene=house2
	$martdoor.next_scene=mart
	$pokemoncenterdoor.next_scene=pokemon_center
	$gymdoor.next_scene=pewter_gym
	$museumdoor2.next_scene = museum_second_entrance

func _on_player_colliding(value):
	if value==true and PlayerData.colliding_character== "3":
		#$NPC_museum/AnimationPlayer.current_animation="walk_to_museum"
		$NPC_museum/AnimationPlayer.play("walk_to_museum")
	elif value==true and PlayerData.colliding_character == "3_after":
		$NPC_museum/AnimationPlayer.play("walk_back")
	elif value==true and PlayerData.colliding_character == "4":
		$NPC_gym/AnimationPlayer.play("walk_to_gym")
	elif value==true and PlayerData.colliding_character == "4_after":
		$NPC_gym/AnimationPlayer.play("walk_back_gym")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="walk_to_museum":
		$NPC_museum/AnimationPlayer.stop()
		PlayerData.colliding_character = "3_after"
		PlayerData.is_colliding_with = 4
		$player._on_player_area_entered(self.get_node("NPC_museum"))
	elif anim_name=="walk_back":
		$NPC_museum/AnimationPlayer.stop()
		PlayerData.colliding_character = "1"
	elif anim_name=="walk_to_gym":
		$NPC_gym/AnimationPlayer.stop()
		PlayerData.colliding_character = "4_after"
		PlayerData.is_colliding_with = 4
		$player._on_player_area_entered(self.get_node("NPC_gym"))
	elif anim_name=="walk_back_gym":
		$NPC_gym/AnimationPlayer.stop()
		PlayerData.colliding_character = "1"
		
func _on_mainentrancemuseum_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(museum_main)

func _on_to_viridian_forest_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(viridian_forest)

func _on_to_route3_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(route3)

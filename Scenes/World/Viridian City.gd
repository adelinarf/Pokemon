extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var route1 = load("res://Scenes/World/Routes/Route 1.tscn")
onready var route2 = preload("res://Scenes/World/Routes/Route 2.tscn")
onready var mart = preload("res://Scenes/World/Viridian City/Mall.tscn")
onready var pokemon_center = preload("res://Scenes/World/Viridian City/Pokemon Center.tscn")
onready var house1 = preload("res://Scenes/World/Viridian City/house1.tscn")
onready var house2 = preload("res://Scenes/World/Viridian City/House2.tscn")
onready var npc = get_node("npc package")
onready var animation_walk=get_node("npc package/AnimationPlayer")
onready var animation_move=get_node("npc package/AnimatedSprite")
onready var collision_box = get_node("attempt_enter_pokemon_mart")

func _ready() -> void:
	PlayerData.current_dialogue = PlayerData.dialogue.viridian_city
	PlayerData.is_in[0] = "ViridianCity"
	animation_walk.stop()
	$house2door.next_scene = house2
	$martdoor.next_scene = mart
	$house1door.next_scene = house1
	$pokemoncenterdoor.next_scene = pokemon_center
	$grandpa/AnimationPlayer.stop()
	if PlayerData.got_pokedex==true:
		$grandpa.number_of_character_in_dialogue="4_after"
		$NPC2.number_of_character_in_dialogue="3_after"
		$grandpa.regular_character=false
		$grandpa.advice_character = true
		$grandpa.position=Vector2(392,-642)
		#$grandpa/AnimationPlayer.play("walk")
		$attempt_enter_pokemon_mart.collision_layer=1
	else:
		$attempt_enter_pokemon_mart.collision_layer=2

func _process(delta):
	PlayerData.show_right_dialogue($"npc package")
	PlayerData.show_right_dialogue($giver)

func _on_to_route_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to(route1)

var talked = false
func _on_attempt_enter_pokemon_mart_area_entered(area):
	PlayerData.colliding_character = "Clerk"
	PlayerData.is_colliding_with = 3
	if area.is_in_group("player") and talked==false:
		print ("ENTERING")
		talked=true
		npc.get_node("AnimationPlayer").play("walking right")
		$player.stop_moving=true
		$player._on_player_area_entered(npc)
		PlayerData.first_time_viridian=false


func _on_player_colliding(value):
	if value==true:
		$player.stop_moving=false
		
		


func _on_to_route_2_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(route2)


func _on_Viridian_City_tree_exiting():
	PlayerData.colliding_character="1"

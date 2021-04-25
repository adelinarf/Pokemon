extends Node2D


onready var route12 = null #cargar escena cuando este lista
onready var route8 = load("res://Scenes/World/Routes/Route 8.tscn")
onready var route10 = load("res://Scenes/World/Routes/Route 10.tscn")
onready var pokemon_center = null
onready var house = preload("res://Scenes/World/Lavender Town/House2.tscn")
onready var house2 = preload("res://Scenes/World/Lavender Town/house1.tscn")
onready var mart = load("res://Scenes/World/Viridian City/Mall.tscn")
onready var pokemontower = preload("res://Scenes/World/Lavender Town/Pokemon Tower PB.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town.tscn"
	$DoorCenter.next_scene =pokemon_center
	$Door.next_scene = house
	$Door2.next_scene = house
	$Door3.next_scene = house2
	$DoorMart.next_scene = mart
	$PokemonTower.next_scene = pokemontower

func _on_to_route12_area_entered(area):
	get_tree().change_scene_to(route12)

func _on_to_route8_area_entered(area):
	get_tree().change_scene_to(route8)

func _on_to_route10_area_entered(area):
	get_tree().change_scene_to(route10)

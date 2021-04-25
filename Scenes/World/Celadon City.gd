extends Node2D

onready var mansion = load("res://Scenes/World/Celadon City/Celadon Apartments PB.tscn")
onready var pokemon_center = load("res://Scenes/World/Viridian City/Pokemon Center.tscn")
onready var department_store = preload("res://Scenes/World/Celadon City/Celadon Department Store.tscn")
onready var casino = preload("res://Scenes/World/Celadon City/Celadon Game Corner.tscn")
onready var restaurant = preload("res://Scenes/World/Celadon City/Celadon Restaurant.tscn")
onready var hotel = preload("res://Scenes/World/Celadon City/Celadon Hotel.tscn")
onready var house = preload("res://Scenes/World/Celadon City/House1.tscn")
onready var gym = preload("res://Scenes/World/Celadon City/Celadon Gym.tscn")
onready var casino_prizes = preload("res://Scenes/World/Celadon City/Celadon Game Corner Prize.tscn")
var route7 = load("res://Scenes/World/Routes/Route 7.tscn")
var route16 = null

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.celadon_city
	PlayerData.is_in[0] = "CeladonCity"
	PlayerData.is_in[1] = "res://Scenes/World/Celadon City.tscn"
	PlayerData.colliding_character = "2"
	$Mansion.next_scene = mansion
	$DoorCenter.next_scene = pokemon_center
	$Store.next_scene = department_store
	$Store2.next_scene = department_store
	$Casino.next_scene = casino
	$Restaurant.next_scene = restaurant
	$Hotel.next_scene = hotel
	$House.next_scene = house
	$Gym.next_scene = gym
	$"Casino prizes".next_scene = casino_prizes

func _on_to_route7_area_entered(area):
	get_tree().change_scene_to(route7)

func _on_to_route16_area_entered(area):
	get_tree().change_scene_to(route16)

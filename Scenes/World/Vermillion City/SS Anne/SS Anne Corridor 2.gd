extends Node2D

onready var corridor1 = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 1.tscn")
onready var deck = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Deck.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 2.tscn"
	PlayerData.colliding_character="1"
	$Corridor1.next_scene = corridor1
	$Deck.next_scene = deck
	


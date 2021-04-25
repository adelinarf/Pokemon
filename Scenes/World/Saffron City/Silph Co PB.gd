extends Node2D

var p1 = preload("res://Scenes/World/Saffron City/Silph Co P1.tscn")
var saffron_city = load("res://Scenes/World/Saffron City.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
	PlayerData.is_in[0] = "SaffronCity"
	PlayerData.is_in[1] = "res://Scenes/World/Saffron City/Silph Co PB.tscn"
	$Door.next_scene = saffron_city
	$Stairs.next_scene = p1

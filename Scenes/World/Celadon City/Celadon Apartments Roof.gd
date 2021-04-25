extends Node2D

var prev_floor = load("res://Scenes/World/Celadon City/Celadon Apartments 2nd floor.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.celadon_city
	PlayerData.is_in[0] = "CeladonCity"
	PlayerData.is_in[1] = "res://Scenes/World/Celadon City/Celadon Apartments Roof.tscn"
	$Stairs.next_scene = prev_floor

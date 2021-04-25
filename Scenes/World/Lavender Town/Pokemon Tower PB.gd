extends Node2D

var lavender_town = load("res://Scenes/World/Lavender Town.tscn")
var next_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower First Floor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/Pokemon Tower PB.tscn"
	$"Main entrance".next_scene = lavender_town
	$Stairs.next_scene = next_floor
	

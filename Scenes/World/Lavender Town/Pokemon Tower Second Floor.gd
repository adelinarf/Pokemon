extends Node2D

var next_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Third Floor.tscn")
var prev_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower First Floor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/Pokemon Tower Second Floor.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	$upstairs.next_scene = next_floor
	$downstairs.next_scene = prev_floor
	

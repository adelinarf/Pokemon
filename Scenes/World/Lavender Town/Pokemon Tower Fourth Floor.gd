extends Node2D

var next_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Fifth Floor.tscn")
var prev_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Third Floor.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/Pokemon Tower Fourth Floor.tscn"
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"Trainer 8")
	PlayerData.show_right_dialogue($"Trainer 9")
	PlayerData.show_right_dialogue($"Trainer 10")
	$upstairs.next_scene = next_floor
	$downstairs.next_scene = prev_floor

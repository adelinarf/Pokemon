extends Node2D


var prev_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Fifth Floor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/Pokemon Tower Sixth Floor.tscn"
	PlayerData.show_right_dialogue($"Trainer 14")
	PlayerData.show_right_dialogue($"Trainer 15")
	PlayerData.show_right_dialogue($"Trainer 16")
	$downstairs.next_scene = prev_floor

extends Node2D


var next_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Sixth Floor.tscn")
var prev_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Fourth Floor.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/Pokemon Tower Fifth Floor.tscn"
	PlayerData.show_right_dialogue($"Trainer 11")
	PlayerData.show_right_dialogue($"Trainer 12")
	PlayerData.show_right_dialogue($"Trainer 13")
	$upstairs.next_scene = next_floor
	$downstairs.next_scene = prev_floor

func _on_dont_cross_area_entered(area):
	if PlayerData.defeated_marowak == false:
		PlayerData.colliding_character="Ghost"
		PlayerData.is_colliding_with = 4

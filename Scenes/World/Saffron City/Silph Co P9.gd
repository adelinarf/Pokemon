extends Node2D

var prev = load("res://Scenes/World/Saffron City/Silph Co P8.tscn")
var next = preload("res://Scenes/World/Saffron City/Silph Co P10.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
	PlayerData.is_in[0] = "SaffronCity"
	PlayerData.is_in[1] = "res://Scenes/World/Saffron City/Silph Co P9.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	$downstairs.next_scene = prev 
	$upstairs.next_scene = next

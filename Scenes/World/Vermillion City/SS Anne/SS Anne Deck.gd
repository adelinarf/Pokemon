extends Node2D

onready var corridor2 = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/SS Anne Deck.tscn"
	PlayerData.colliding_character="1"
	PlayerData.show_right_dialogue($"Trainer 15")
	PlayerData.show_right_dialogue($"Trainer 16")
	

func _on_to_corridor2_area_entered(area):
	get_tree().change_scene_to(corridor2)

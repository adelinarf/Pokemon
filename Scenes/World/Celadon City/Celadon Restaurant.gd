extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.celadon_city
	PlayerData.is_in[0] = "CeladonCity"
	PlayerData.is_in[1] = "res://Scenes/World/Celadon City/Celadon Restaurant.tscn"

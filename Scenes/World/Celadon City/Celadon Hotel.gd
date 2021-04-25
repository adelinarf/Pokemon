extends Node2D

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.celadon_city
	PlayerData.is_in[0] = "CeladonCity"
	PlayerData.is_in[1] = "res://Scenes/World/Celadon City/Celadon Hotel.tscn"

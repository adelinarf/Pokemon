extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_player_area_entered(area: Area2D) -> void:
	if area.name == "NPC":
		PlayerData.is_in[0] = "ViridianCity"
		PlayerData.colliding_character = "PokemonCenter"
	elif area.name == "NPC2":
		PlayerData.is_in[0] = "ViridianCity"
		PlayerData.colliding_character = "PC"
	elif area.name == "NPC3":
		PlayerData.is_in[0] = "Route1"
		PlayerData.colliding_character = "Mall"
	elif area.name == "NPC4":
		PlayerData.is_in[0] = "Route1"
		PlayerData.colliding_character = "1"
	elif area.name == "NPC5":
		PlayerData.is_in[0] = "PalletTown"
		PlayerData.colliding_character = "1"
		
		
		

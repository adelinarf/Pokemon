extends Node2D

onready var entrance = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Entrance.tscn")
onready var room_orange = preload("res://Scenes/World/Vermillion City/SS Anne/Rooms/SS Anne Room Orange.tscn")
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 3.tscn"
	PlayerData.colliding_character="1"
	$Entrance.next_scene = entrance
	$"14".next_scene=room_orange
	$"15".next_scene=room_orange
	$"16".next_scene=room_orange
	$"17".next_scene=room_orange
	$"18".next_scene=room_orange
	
func _on_14_area_entered(area):
	PlayerData.room_in_ss_anne = 14

func _on_15_area_entered(area):
	PlayerData.room_in_ss_anne = 15

func _on_16_area_entered(area):
	PlayerData.room_in_ss_anne = 16

func _on_17_area_entered(area):
	PlayerData.room_in_ss_anne = 17

func _on_18_area_entered(area):
	PlayerData.room_in_ss_anne = 18

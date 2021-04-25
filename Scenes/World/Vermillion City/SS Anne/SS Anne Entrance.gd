extends Node2D

onready var kitchen = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Kitchen.tscn")
onready var corridor1 = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 1.tscn")
onready var corridor3 = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 3.tscn")
onready var room_green = preload("res://Scenes/World/Vermillion City/SS Anne/Rooms/SS Anne Room Green.tscn")
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/SS Anne Entrance.tscn"
	PlayerData.colliding_character="1"
	$Kitchen.next_scene = kitchen
	$Corridor1.next_scene = corridor1
	$Corridor3.next_scene = corridor3
	$"1".next_scene=room_green
	$"2".next_scene=room_green
	$"3".next_scene=room_green
	$"4".next_scene=room_green
	$"5".next_scene=room_green
	$"6".next_scene=room_green
	$"7".next_scene=room_green

func _on_1_area_entered(area):
	PlayerData.room_in_ss_anne = 1

func _on_2_area_entered(area):
	PlayerData.room_in_ss_anne = 2

func _on_3_area_entered(area):
	PlayerData.room_in_ss_anne = 3

func _on_4_area_entered(area):
	PlayerData.room_in_ss_anne = 4

func _on_5_area_entered(area):
	PlayerData.room_in_ss_anne = 5

func _on_6_area_entered(area):
	PlayerData.room_in_ss_anne = 6

func _on_7_area_entered(area):
	PlayerData.room_in_ss_anne = 7

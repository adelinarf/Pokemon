extends Node2D

onready var entrance = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Entrance.tscn")
onready var office = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Office.tscn")
onready var corridor2 = preload("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 2.tscn")
onready var room_orange = preload("res://Scenes/World/Vermillion City/SS Anne/Rooms/SS Anne Room Orange.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 1.tscn"
	PlayerData.colliding_character="1"
	$Entrance.next_scene = entrance
	$Office.next_scene = office
	$Corridor2.next_scene = corridor2
	if PlayerData.first_time_anne ==true:
		pass
	elif PlayerData.first_time_anne == false:
		$Rival.free()
		$try_enter_office.free()
	$"8".next_scene=room_orange
	$"9".next_scene=room_orange
	$"10".next_scene=room_orange
	$"11".next_scene=room_orange
	$"12".next_scene=room_orange
	$"13".next_scene=room_orange


func _on_try_enter_office_area_entered(area):
	if area.is_in_group("player"):
		if PlayerData.first_time_anne == true:
			$Rival/AnimationPlayer.play("walk")
			$player.stop_moving = true
			PlayerData.colliding_character = "Rival_Fight"
			PlayerData.is_colliding_with=2
			PlayerData.first_time_anne = false
		else:
			pass


func _on_8_area_entered(area):
	PlayerData.room_in_ss_anne = 8

func _on_9_area_entered(area):
	PlayerData.room_in_ss_anne = 9

func _on_10_area_entered(area):
	PlayerData.room_in_ss_anne = 10

func _on_11_area_entered(area):
	PlayerData.room_in_ss_anne = 11

func _on_12_area_entered(area):
	PlayerData.room_in_ss_anne = 12

func _on_13_area_entered(area):
	PlayerData.room_in_ss_anne = 13

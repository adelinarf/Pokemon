extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var route24 = null
var bill_house = preload("res://Scenes/World/Routes/Bill's House.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route25
	PlayerData.is_in[0]="Route25"
	PlayerData.is_in[1]="res://Scenes/World/Routes/Route 25.tscn"
	PlayerData.colliding_character="Trainer 1"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"Trainer 8")
	PlayerData.show_right_dialogue($"Trainer 9")
	$Bill_house.next_scene = bill_house

func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_to_route24_area_entered(area):
	get_tree().change_scene_to(route24)

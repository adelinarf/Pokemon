extends Node2D

onready var route25 = preload("res://Scenes/World/Routes/Route 25.tscn")
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route24
	PlayerData.is_in[0]="Route24"
	PlayerData.is_in[1]="res://Scenes/World/Routes/Route 24.tscn"
	PlayerData.colliding_character="Trainer 1"
	$"Trainer 1/AnimatedSprite".flip_h = true
	$"Trainer 3/AnimatedSprite".flip_h = true
	$"Trainer 5/AnimatedSprite".flip_h = true
	$"Trainer 7/AnimatedSprite".flip_h = true
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")


func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")


func _on_to_route25_area_entered(area):
	get_tree().change_scene_to(route25)

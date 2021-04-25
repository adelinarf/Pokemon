extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mountain_moon_aisles = load("res://Scenes/World/Mountain Moon 3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.mt_moon
	$player.position = PlayerData.find_player_pos()
	PlayerData.is_in[0]="MtMoon"
	PlayerData.is_in[1]="res://Scenes/World/Mountain Moon.tscn"
	PlayerData.colliding_character="Trainer 1"
	$stair.next_scene=mountain_moon_aisles
	$stair2.next_scene = mountain_moon_aisles
	$stair3.next_scene=mountain_moon_aisles
	PlayerData.show_right_dialogue($trainer1)
	PlayerData.show_right_dialogue($trainer2)
	PlayerData.show_right_dialogue($trainer3)
	PlayerData.show_right_dialogue($trainer4)
	PlayerData.show_right_dialogue($trainer5)
	PlayerData.show_right_dialogue($trainer6)

func _on_player_body_entered(body: Node) -> void:
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5000) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_Mountain_Moon_tree_exiting():
	PlayerData.is_in[2]=$player.position

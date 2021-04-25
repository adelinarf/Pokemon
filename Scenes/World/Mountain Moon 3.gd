extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mountain_moon1 = load("res://Scenes/World/Mountain Moon.tscn")
var mountain_moon2 = preload("res://Scenes/World/Mountain Moon 2.tscn")
var route4 = preload("res://Scenes/World/Routes/Route 4.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.mt_moon
	$player.position = PlayerData.find_player_pos()
	PlayerData.is_in[0]="MtMoon"
	PlayerData.is_in[1] = "res://Scenes/World/Mountain Moon 3.tscn"
	PlayerData.colliding_character="Trainer 1"
	$"stair down".next_scene = mountain_moon2
	$"stair down2".next_scene=mountain_moon2
	$"stair down3".next_scene=mountain_moon2
	$"stair down4".next_scene=mountain_moon2
	$"stair up".next_scene=mountain_moon1
	$"stair up2".next_scene=mountain_moon1
	$"stair up3".next_scene=route4
	$"stair up4".next_scene=mountain_moon1
	PlayerData.show_right_dialogue($NPC)

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

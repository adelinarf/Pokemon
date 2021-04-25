extends Node2D

var prev = load("res://Scenes/World/Saffron City/Silph Co P9.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
	PlayerData.is_in[0] = "SaffronCity"
	PlayerData.is_in[1] = "res://Scenes/World/Saffron City/Silph Co P10.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	$downstairs.next_scene = prev
	if PlayerData.defeated_team_rocket==false:
		pass
	elif PlayerData.defeated_team_rocket==true:
		$Giovanni.free()

func _on_player_colliding(value):
	if PlayerData.colliding_character=="Giovanni after":
		$Giovanni/AnimationPlayer.play("leave")


func _on_AnimationPlayer_animation_finished(anim_name):
	$Giovanni/AnimationPlayer.stop()
	PlayerData.is_colliding_with = null
	PlayerData.colliding_character = "Giovanni"
	$Giovanni.visible=false
	PlayerData.defeated_team_rocket=true

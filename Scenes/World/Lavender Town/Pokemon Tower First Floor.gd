extends Node2D

var next_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower Second Floor.tscn")
var prev_floor = load("res://Scenes/World/Lavender Town/Pokemon Tower PB.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/Pokemon Tower First Floor.tscn"
	PlayerData.show_right_dialogue($Rival)
	$upstairs.next_scene = next_floor
	$downstairs.next_scene = prev_floor
	if $Rival.number_of_character_in_dialogue=="Rival_Fight after" and PlayerData.first_time_tower==true:
		$Rival.position = Vector2(960,695)
		$not_able_to_cross.collision_layer=1
		$not_able_to_cross.collision_mask=1
		$not_able_to_cross.free()
	elif $Rival.number_of_character_in_dialogue=="Rival_Fight after":
		pass
	if PlayerData.first_time_tower==true:
		pass
	elif PlayerData.first_time_tower==false:
		$Rival.free()
		$not_able_to_cross.free()
		


func _on_try_pass_area_entered(area):
	if area.is_in_group("player"):
		if PlayerData.first_time_tower==true:
			#$Rival/AnimationPlayer.play("walk")
			$Rival/AnimationPlayer.play("enter")
			$player._on_player_area_entered($Rival)
			$player.stop_moving = true
			PlayerData.colliding_character = "Rival_Fight"
			PlayerData.is_colliding_with=2
			#PlayerData.first_time_tower=false
		else:
			pass


func _on_player_colliding(value):
	if value == true and PlayerData.colliding_character == "Rival_Fight after" and PlayerData.first_time_tower==true:
		$Rival/AnimationPlayer.play("leave")
		PlayerData.first_time_tower=false
		
		


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "leave":
		$Rival/AnimationPlayer.stop()
	elif anim_name == "enter":
		$Rival/AnimationPlayer.stop()
		

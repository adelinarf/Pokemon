extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.is_in[0]="PalletTown"
	PlayerData.is_colliding_with=4
	$player.stop_moving = true
	$player._on_player_area_entered($Rival)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_player_colliding(value):
	if value==true and PlayerData.colliding_character=="Rival_leave_lab":
		$Rival/AnimationPlayer.play("walk down")
		PlayerData.colliding_character="Oak"


func _on_AnimationPlayer_animation_finished(anim_name):
	$Rival/AnimationPlayer.stop()
	if anim_name =="walk down":
		$player.stop_moving = false
		get_tree().change_scene("res://Scenes/World/Pallet Town/Oak's_Lab_before_and_after_getting_pokemon.tscn")

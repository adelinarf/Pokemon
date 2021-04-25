extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player_house = preload("res://Scenes/World/Pallet Town/Hero_home_1_floor_.tscn")
onready var rival_house = preload("res://Scenes/World/Pallet Town/Rival_home_.tscn")
onready var laboratory = preload("res://Scenes/World/Pallet Town/Oak's_Lab_before_and_after_getting_pokemon.tscn")
onready var next_scene = preload("res://Scenes/World/Routes/Route 1.tscn")
onready var timer = get_node("Timer")
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	PlayerData.current_dialogue = PlayerData.dialogue.pallet_town
	PlayerData.is_in[0] ="PalletTown"
	PlayerData.is_in[1] ="res://Scenes/World/Pallet Town.tscn"
	PlayerData.colliding_character="1"
	if PlayerData.first_time == true:
		$Change_scene.free()
	elif PlayerData.first_time == false:
		$getting_out_town.free()
		$Oak.free()
		if PlayerData.first_time_viridian==false and PlayerData.got_pokedex == false:
			laboratory = preload("res://Scenes/World/Pallet Town/Oak's_Lab_.tscn")
		else:
			laboratory = preload("res://Scenes/World/Pallet Town/Oak's_Lab_before_and_after_getting_pokemon.tscn")
		#$Timer.free()
	$Door.next_scene = player_house
	$Door2.next_scene = rival_house
	$Door3.next_scene = laboratory
	#$Dialog_box.visible = false
	timer.set_wait_time(4)

func _on_getting_out_town_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$Oak.visible = true
		timer.start()
		$Oak/AnimationPlayer.play("walking up")
		PlayerData.colliding_character = "Oak"
		PlayerData.is_colliding_with = 4
		$player.stop_moving=true
	print ("Hey where you going")
var done=false
func _on_Timer_timeout() -> void:
	done = true
	#$player._on_player_area_entered(self.get_node("Oak"))
 #$Dialog_box/WindowDialog.visible = false
	#$Oak/AnimationPlayer.current_animation = "walking down"
	#$Oak/AnimationPlayer.play("walking down")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "walking down":
		$Oak/AnimationPlayer.current_animation = "walking right"
		$Oak/AnimationPlayer.play("walking right")
	if anim_name == "walking right":
		$Oak/AnimationPlayer.stop()
		$player.stop_moving=false
		$player.dont_show_dialogue = false
		get_tree().change_scene("res://Scenes/World/Pallet Town/Oak's_Lab_.tscn")

func _unhandled_input(event: InputEvent) -> void:
	pass
	#if event.is_action_pressed("space") and animation_trigger==true:
	#	$Oak/AnimationPlayer.play("walking down")


func _on_Change_scene_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to(next_scene)

var animation_trigger = null
func _on_player_colliding(value) -> void:
	animation_trigger = value
	if animation_trigger == true and done==true and PlayerData.colliding_character == "Oak":
		$Oak/AnimationPlayer.current_animation = "walking down"
		$Oak/AnimationPlayer.play("walking down")
		$player.dont_show_dialogue = true

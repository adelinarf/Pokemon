extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var viridiancity=load("res://Scenes/World/Viridian City.tscn")
onready var viridianforest = preload("res://Scenes/World/Viridian Forest.tscn")
onready var diglettcave = null
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route2
	PlayerData.is_in[0] = "Route2"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 2.tscn"
	$"Diglett Cave".next_scene = diglettcave
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_to_viridian_city_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(viridiancity)


func _on_player_body_entered(body):
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")


func _on_to_viridian_forest_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(viridianforest)

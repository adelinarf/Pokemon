extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cerulean_city = load("res://Scenes/World/Cerulean City.tscn")
onready var underground_path = preload("res://Scenes/World/Underground Path.tscn")
onready var tunnel = preload("res://Scenes/World/Tunnel.tscn")
var daycare = preload("res://Scenes/World/Routes/Daycare.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route5
	PlayerData.is_in[0]="Route5"
	PlayerData.is_in[1]="res://Scenes/World/Routes/Route 5.tscn"
	PlayerData.colliding_character = "Daycare"
	$Underground_path.next_scene = underground_path
	$Daycare.next_scene = daycare
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_to_cerulean_city_area_entered(area):
	get_tree().change_scene_to(cerulean_city)

func _on_tunnel2_area_entered(area):
	get_tree().change_scene_to(tunnel)

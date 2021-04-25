extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cerulean_city = load("res://Scenes/World/Cerulean City.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.cerulean_city
	PlayerData.is_in[0]="CeruleanCity"
	PlayerData.is_in[1]="res://Scenes/World/Cerulean City/Cerulean Gym.tscn"
	$Door.next_scene = cerulean_city
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

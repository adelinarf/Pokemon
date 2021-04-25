extends Node2D

onready var underground_entrance = load("res://Scenes/World/Underground Path.tscn")
onready var underground_exit= load("res://Scenes/World/Underground Path3.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route5
	#PlayerData.is_in[0]="Route5"
	#PlayerData.is_in[1]="res://Scenes/World/Underground Path.tscn"
	PlayerData.colliding_character="Building3"
	$Stair.next_scene = underground_entrance
	$Stair2.next_scene = underground_exit
	



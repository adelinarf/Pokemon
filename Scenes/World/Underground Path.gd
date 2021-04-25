extends Node2D

onready var to_underground_path = preload("res://Scenes/World/Underground Path2.tscn")
onready var to = load(PlayerData.is_in[1])
var exit = null
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route5
	if PlayerData.is_in[0]=="Route5":
		exit = "Route6"
	elif PlayerData.is_in[0]=="Route6":
		exit = "Route5"
	elif PlayerData.is_in[0]=="Route7":
		exit = "Route8"
	elif PlayerData.is_in[0]=="Route8":
		exit = "Route7"
	
	
	#PlayerData.is_in[0]="Route5"
	#PlayerData.is_in[1]="res://Scenes/World/Underground Path.tscn"
	PlayerData.colliding_character="Building3"
	$Door.next_scene = to
	$Stair.next_scene = to_underground_path



func _on_Underground_Path_tree_exiting():
	PlayerData.is_in[0]=exit

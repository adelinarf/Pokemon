extends Node2D

onready var to_route6 = load("res://Scenes/World/Routes/Route 6.tscn")
onready var to_route5 = load("res://Scenes/World/Routes/Route 5.tscn")
onready var to_route7 = load("res://Scenes/World/Routes/Route 7.tscn")
onready var to_route8 = load("res://Scenes/World/Routes/Route 8.tscn")
onready var to_underground_path = preload("res://Scenes/World/Underground Path2.tscn")
var exit = null
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route5
	if PlayerData.is_in[0]=="Route5":
		$Door.next_scene = to_route5
	elif PlayerData.is_in[0]=="Route6":
		$Door.next_scene = to_route6
	elif PlayerData.is_in[0]=="Route7":
		$Door.next_scene = to_route7
	elif PlayerData.is_in[0]=="Route8":
		$Door.next_scene = to_route8
	
	PlayerData.is_in[0]="Route5"
	#PlayerData.is_in[1]="res://Scenes/World/Underground Path.tscn"
	PlayerData.colliding_character="Building3"
	$Stair.next_scene = to_underground_path



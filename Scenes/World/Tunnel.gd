extends Node2D


onready var to_route5 = load("res://Scenes/World/Routes/Route 5.tscn")
onready var to_route6 = preload("res://Scenes/World/Routes/Route 6.tscn")
onready var to_route8 = load("res://Scenes/World/Routes/Route 8.tscn")
onready var to_route7 = load("res://Scenes/World/Routes/Route 7.tscn")
onready var saffron_city = load("res://Scenes/World/Saffron City.tscn")
onready var fucshia_city = load("res://Scenes/World/Fuchsia City.tscn")
onready var route18 = load("res://Scenes/World/Routes/Route 18.tscn")
onready var route15 = load("res://Scenes/World/Routes/Route 15.tscn")
var exit = null
var from = load(PlayerData.is_in[1])
# Called when the node enters the scene tree for the first time.
func _ready():
	#PlayerData.is_in[0]="Route5"
	#PlayerData.is_in[1]="res://Scenes/World/Tunnel.tscn"
	#PlayerData.colliding_character="Guard"
	choose_exit()
	$Door.next_scene = from
	$Door2.next_scene = exit
	var a=has_tea()
	if a==true and PlayerData.can_cross_tunnel==false:
		$NPC.number_of_character_in_dialogue = "Guard" #deldialogo de ruta7
		PlayerData.can_cross_tunnel = true
	elif a==false and PlayerData.can_cross_tunnel==false:
		pass
	elif a==false and PlayerData.can_cross_tunnel==true:
		$NPC.number_of_character_in_dialogue = "Guard after"

func has_tea()->bool:
	var has_tea=false
	for x in range(len(PlayerData.player_test["Bag"][1]["Content"])):
		if PlayerData.player_test["Bag"][1]["Content"][x][0]=="Tea":
			has_tea=true
		else:
			has_tea=false
	return (has_tea)
			



func choose_exit():
	if PlayerData.is_in[0]=="SaffronCity":
		if PlayerData.is_in[2].x<=338:
			exit = to_route7
		elif PlayerData.is_in[2].x>=2050:
			exit = to_route8
		elif PlayerData.is_in[2].y>1000:
			exit = to_route6
		elif PlayerData.is_in[2].y<0:
			exit = to_route5
	elif PlayerData.is_in[0]=="Route5" or PlayerData.is_in[0]=="Route6" or PlayerData.is_in[0]=="Route7" or PlayerData.is_in[0]=="Route8":
		exit = saffron_city
	elif PlayerData.is_in[0]=="Route15" or PlayerData.is_in[0]=="Route18":
		exit = fucshia_city
	elif PlayerData.is_in[0] == "FuchsiaCity":
		if PlayerData.is_in[2].x<=-110:
			print("SALIDA RUTA 18")
			exit = route18
		elif PlayerData.is_in[2].x>=1200:
			exit = route15
			print("SALIDA RUTA 15")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

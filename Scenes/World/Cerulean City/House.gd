extends Node2D

var inside = PlayerData.is_in[0]
onready var vermilion = load("res://Scenes/World/Vermilion City.tscn")
onready var cerulean = load("res://Scenes/World/Cerulean City.tscn")

func _ready():
	if inside =="CeruleanCity":
		PlayerData.current_dialogue = PlayerData.dialogue.cerulean_city
		PlayerData.colliding_character = "12"
		$Door.next_scene = cerulean
	elif inside == "VermilionCity":
		PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
		PlayerData.colliding_character="1"
		$Door.next_scene = vermilion
	PlayerData.is_in[1]="res://Scenes/World/Cerulean City/House.tscn"

func _on_player_body_entered(body):
	var collider = $player.get_node("RayCast2D").get_collider()
	var normal = $player.get_node("RayCast2D").get_collision_normal()
	var point = $player.get_node("RayCast2D").get_collision_point()
	var tiles = get_node("Inside objects")
	if body.name == "Inside objects":
		var coords = body.world_to_map(body.to_local($player.global_position))
		#coords = coords - Vector2(0,1)
		var direction = $player.direction
		if direction == "up":
			coords = coords - Vector2(0,1)
		elif direction =="down":
			coords = coords - Vector2(0,-1)
		elif direction == "left":
			coords = coords - Vector2(1,0)
		else:
			coords = coords - Vector2(-1,0)
		var tile_id = tiles.get_cellv(coords)
		print ("You're colliding with", tile_id)
		$player.is_inside=tile_id
		var a = PlayerData.set_tile_dialogue(tile_id)
		if a !=null:
			$player.dialogue._init()
			$player.dialogue.visible = true
		else:
			pass

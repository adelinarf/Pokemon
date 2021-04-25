extends Node2D

onready var route9 = load("res://Scenes/World/Routes/Route 9.tscn")
onready var lavender_town = preload("res://Scenes/World/Lavender Town.tscn")
onready var pokemon_center = load("res://Scenes/World/Viridian City/Pokemon Center.tscn")
onready var rock_tunnel = load("res://Scenes/World/Routes/Rock tunnel.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route10
	PlayerData.is_in[0] = "Route10"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 10.tscn"
	"""
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"Trainer 8")
	PlayerData.show_right_dialogue($"Trainer 9")"""
	if PlayerData.is_in[2]==Vector2(462.775,2040.968):
		$player.position = PlayerData.is_in[2]
	else:
		pass
	$DoorCenter.next_scene = pokemon_center
	$to_rock_tunnel.next_scene = rock_tunnel
	$to_rock_tunnel2.next_scene = rock_tunnel

var fight_pokemon = false
func _on_player_body_entered(body: Node) -> void:
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()
		fight_pokemon = true
	elif body.name == "collision_elements":
		manage_collision(body)
		
		
func manage_collision(body)->void:
	var collider = $player.get_node("RayCast2D").get_collider()
	var normal = $player.get_node("RayCast2D").get_collision_normal()
	var point = $player.get_node("RayCast2D").get_collision_point()
	var tiles = get_node("collision_elements")
	var coords = body.world_to_map(body.to_local($player.global_position))
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
	if tile_id==10 and direction =="down":
		$player.position.y += 65
		

func _on_Timer_timeout() -> void:
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_player_body_exited(body: Node) -> void:
	$Timer.stop()
	fight_pokemon = false

func _on_to_route9_area_entered(area):
	get_tree().change_scene_to(route9)

func _on_to_lavender_town_area_entered(area):
	get_tree().change_scene_to(lavender_town)

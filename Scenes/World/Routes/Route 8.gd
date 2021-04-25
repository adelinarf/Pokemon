extends Node2D

onready var lavender_town = load("res://Scenes/World/Lavender Town.tscn")
onready var to_underground_path = load("res://Scenes/World/Underground Path.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route8
	PlayerData.is_in[0] = "Route8"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 8.tscn"
	PlayerData.colliding_character = "Guard"
	$underground.next_scene = to_underground_path
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($"Trainer 5")
	PlayerData.show_right_dialogue($"Trainer 6")
	PlayerData.show_right_dialogue($"Trainer 7")
	PlayerData.show_right_dialogue($"Trainer 8")
	PlayerData.show_right_dialogue($"Trainer 9")

var fight_pokemon = false
func _on_player_body_entered(body: Node) -> void:
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()
		fight_pokemon = true
	elif body.name == "collision_element":
		manage_collision(body)
		
		
func manage_collision(body)->void:
	var collider = $player.get_node("RayCast2D").get_collider()
	var normal = $player.get_node("RayCast2D").get_collision_normal()
	var point = $player.get_node("RayCast2D").get_collision_point()
	var tiles = get_node("collision_element")
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


func _on_to_lavender_town_area_entered(area):
	get_tree().change_scene_to(lavender_town)

func _on_tunnel2_area_entered(area):
	get_tree().change_scene("res://Scenes/World/Tunnel.tscn")

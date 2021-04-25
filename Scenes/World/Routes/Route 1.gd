extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var pallet_town = load("res://Scenes/World/Pallet Town.tscn")
onready var viridian_city = preload("res://Scenes/World/Viridian City.tscn")
onready var timer = get_node("Timer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.current_dialogue = PlayerData.dialogue.route1
	PlayerData.is_in[0] = "Route1"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Route 1.tscn"
	$Timer.set_wait_time(3) 

func _process(delta):
	PlayerData.show_right_dialogue($NPC)

func _on_to_pallet_town_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to(pallet_town)

func _on_to_viridian_city_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		get_tree().change_scene_to(viridian_city)

var fight_pokemon = false
func _on_player_body_entered(body: Node) -> void:
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()
		fight_pokemon = true
	elif body.name == "collidewithworld":
		manage_collision(body)
		
		
func manage_collision(body)->void:
	var collider = $player.get_node("RayCast2D").get_collider()
	var normal = $player.get_node("RayCast2D").get_collision_normal()
	var point = $player.get_node("RayCast2D").get_collision_point()
	var tiles = get_node("collidewithworld")
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
		$player.position.y += 70
		

func _on_Timer_timeout() -> void:
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_player_body_exited(body: Node) -> void:
	$Timer.stop()
	fight_pokemon = false

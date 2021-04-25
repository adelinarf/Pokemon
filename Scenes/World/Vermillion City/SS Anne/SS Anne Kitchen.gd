extends Node2D

onready var floor1 = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Entrance.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/SS Anne Kitchen.tscn"
	PlayerData.colliding_character="1"
	$Kitchen_exit.next_scene = floor1


func _on_player_body_entered(body: Node) -> void:
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

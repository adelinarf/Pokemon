extends Node2D

var viridian_city = load("res://Scenes/World/Viridian City.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.current_dialogue = PlayerData.dialogue.viridian_city
	PlayerData.is_in[0] = "ViridianCity"
	PlayerData.is_in[1] = "res://Scenes/World/Viridian City/house1.tscn"
	$Door.next_scene = viridian_city

func _on_player_body_entered(body: Node) -> void:
	var tiles2 = get_node("Inside objects")
	if body.name == "Inside objects":
		var coords = body.world_to_map(body.to_local($player.global_position))
		coords = coords - Vector2(0,1)
		var direction = $player.direction
		if direction == "up":
			coords = coords - Vector2(0,1)
		elif direction =="down":
			coords = coords - Vector2(0,-1)
		elif direction == "left":
			coords = coords - Vector2(1,0)
		else:
			coords = coords - Vector2(-1,0)
		var tile_id = tiles2.get_cellv(coords)
		print ("You're colliding with", tile_id)
		var a = PlayerData.set_tile_dialogue(tile_id)
		if a !=null:
			$player.dialogue._init()
			$player.dialogue.visible = true
		else:
			pass

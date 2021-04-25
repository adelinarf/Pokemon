extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass #var tile_id = collision.collider.get_cellv(tile_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _on_player_area_entered(area: Area2D) -> void:
	print (area.position)

func _on_player_body_entered(body: Node) -> void:

	var collider = $player.get_node("RayCast2D").get_collider()
	var normal = $player.get_node("RayCast2D").get_collision_normal()
	var point = $player.get_node("RayCast2D").get_collision_point()
	var tiles = get_node("TileMap2")
	print (tiles.get_used_cells())
	if body.name == "TileMap2":
		var coords = body.world_to_map(body.to_local($player.global_position))
		print ("TILE",coords)
		coords -= normal
		print (coords)
		coords = coords - Vector2(1,1)
		#print ("Tile",tile_pos)
		#tile_pos -= Vector2(0,1)
		var tile_id = tiles.get_cellv(coords)
		print ("id", tile_id)
	var tiles2 = get_node("Node2D")
	if body.name == "Node2D":
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
		
		

extends Node2D


var lavender_town = load("res://Scenes/World/Lavender Town.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
	PlayerData.is_in[0] = "LavenderTown"
	PlayerData.is_in[1] = "res://Scenes/World/Lavender Town/House2.tscn"
	if PlayerData.defeated_marowak == false:
		$Fuji.free()
	elif PlayerData.defeated_marowak == true:
		$NPC.number_of_character_in_dialogue += " after"
		$NPC2.number_of_character_in_dialogue += " after"
		$Fuji.number_of_character_in_dialogue = "Fuji2"
		PlayerData.show_right_dialogue($Fuji)
	$Door.next_scene = lavender_town
	#se puede usar el player colliding para actualizar a fuji


func has_flute()->bool:
	var has_flute=false
	for x in range(len(PlayerData.player_test["Bag"][1]["Content"])):
		if PlayerData.player_test["Bag"][1]["Content"][x][0]=="Flute":
			has_flute=true
		else:
			has_flute=false
	return (has_flute)

func _process(delta):
	pass #PlayerData.show_right_dialogue($Fuji)


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

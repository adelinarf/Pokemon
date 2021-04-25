extends Node2D

var prev_scene = load("res://Scenes/World/Celadon City/Rocket Hideout B3F.tscn")

func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.celadon_city
	PlayerData.is_in[0] = "CeladonCity"
	PlayerData.is_in[1] = "res://Scenes/World/Celadon City/Rocket Hideout B4F.tscn"
	PlayerData.show_right_dialogue($"Trainer 9")
	PlayerData.show_right_dialogue($"Trainer 10")
	PlayerData.show_right_dialogue($"Trainer 11")
	if PlayerData.first_time_hideout == true:
		PlayerData.show_right_dialogue($Giovanni)
	elif PlayerData.first_time_hideout == false:
		$Giovanni.free()
	$upstairs.next_scene = prev_scene
	
	
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


func _on_player_colliding(value):
	if PlayerData.colliding_character=="Giovanni after":
		$Giovanni/AnimationPlayer.play("leave")
		
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="leave":
		$Giovanni/AnimationPlayer.stop()
		PlayerData.first_time_hideout=false
		PlayerData.is_colliding_with = null
		PlayerData.colliding_character = "Giovanni"

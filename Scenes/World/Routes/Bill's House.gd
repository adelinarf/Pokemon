extends Node2D


var route25 = load("res://Scenes/World/Routes/Route 25.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route25
	PlayerData.is_in[0] = "Route25"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Bill's House.tscn"
	PlayerData.colliding_character="Bill"
	$Door.next_scene = route25
	var a = has_ticket()
	if a == true:
		$Bill.number_of_character_in_dialogue = "Bill_before_leaving"
	elif a == false:
		pass
	
func has_ticket()->bool:
	var has_ticket = false
	for x in range(len(PlayerData.player_test["Bag"][1]["Content"])):
		if PlayerData.player_test["Bag"][1]["Content"][x][0]=="Ticket":
			has_ticket = true
		else:
			has_ticket = false
	return (has_ticket)

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
	var a = has_ticket()
	if value==true and PlayerData.colliding_character=="Machine" and a==false:
		$Bill.number_of_character_in_dialogue = "Bill after"
		PlayerData.player_test["Bag"][1]["Content"].append(["Ticket",1])
		print ("YOU GOT A TICKET")

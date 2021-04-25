extends Node2D


onready var entrance = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Entrance.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/Rooms/SS Anne Room Green.tscn"
	PlayerData.colliding_character="1"
	$Door.next_scene = entrance
	choose_npc()

func choose_npc():
	var room = PlayerData.room_in_ss_anne
	if room == 1:
		$Trainer.number_of_character_in_dialogue = "Trainer 1"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
		$npc_regular.free()
	elif room == 2:
		$Trainer.number_of_character_in_dialogue = "Trainer 2"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
		$npc_regular.free()
	elif room == 3:
		$npc_regular.number_of_character_in_dialogue = "12"
		$Trainer2.free()
		$Trainer.free()
	elif room == 4:
		$npc_regular.number_of_character_in_dialogue = "13"
		$Trainer.number_of_character_in_dialogue = "14"
		$Trainer.regular_character = true
		$Trainer.trainer_npc = false
		$Trainer2.free()
	elif room == 5:
		$Trainer.number_of_character_in_dialogue = "Trainer 3"
		$Trainer2.number_of_character_in_dialogue = "Trainer 4"
		$npc_regular.number_of_character_in_dialogue = "15"
		PlayerData.show_right_dialogue($Trainer)
		PlayerData.show_right_dialogue($Trainer2)
	elif room == 6:
		$npc_regular.number_of_character_in_dialogue = "16"
		$Trainer2.free()
		$Trainer.free()
	elif room == 7:
		$npc_regular.number_of_character_in_dialogue = "16"
		$Trainer2.free()
		$Trainer.free()
		

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

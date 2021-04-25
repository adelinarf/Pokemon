extends Node2D


onready var corridor1 = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 1.tscn")
onready var corridor3 = load("res://Scenes/World/Vermillion City/SS Anne/SS Anne Corridor 3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
	PlayerData.is_in[0]="VermilionCity"
	PlayerData.is_in[1]="res://Scenes/World/Vermillion City/SS Anne/Rooms/SS Anne Room Orange.tscn"
	PlayerData.colliding_character="1"
	if PlayerData.room_in_ss_anne<=13:
		$Door.next_scene = corridor1
	elif PlayerData.room_in_ss_anne>13:
		$Door.next_scene = corridor3
	choose_npc()
	
func choose_npc():
	var room = PlayerData.room_in_ss_anne
	if room == 8:
		$Trainer.number_of_character_in_dialogue = "Trainer 5"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
	elif room == 9:
		$Trainer.number_of_character_in_dialogue = "Trainer 6"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
	elif room == 10:
		$Trainer.number_of_character_in_dialogue = "Trainer 7"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
	elif room == 11:
		$Trainer.number_of_character_in_dialogue = "Trainer 8"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
	elif room == 12:
		$Trainer.number_of_character_in_dialogue = "Trainer 9"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
	elif room == 13:
		$Trainer.number_of_character_in_dialogue = "Trainer 10"
		PlayerData.show_right_dialogue($Trainer)
		$Trainer2.free()
	elif room == 14:
		$Trainer.number_of_character_in_dialogue = "Trainer 11"
		$Trainer2.number_of_character_in_dialogue = "Trainer 12"
		PlayerData.show_right_dialogue($Trainer)
		PlayerData.show_right_dialogue($Trainer2)
	elif room == 15:
		$Trainer.number_of_character_in_dialogue = "20"
		$Trainer2.number_of_character_in_dialogue = "21"
		$Trainer.regular_character = true
		$Trainer2.regular_character = true
		$Trainer2.trainer_npc = false
		$Trainer.trainer_npc = false
	elif room == 16:
		$Trainer.number_of_character_in_dialogue = "Trainer 13"
		$Trainer2.number_of_character_in_dialogue = "Trainer 14"
		PlayerData.show_right_dialogue($Trainer)
		PlayerData.show_right_dialogue($Trainer2)
	elif room == 17:
		$Trainer.number_of_character_in_dialogue = "22"
		$Trainer2.number_of_character_in_dialogue = "23"
		$Trainer.regular_character = true
		$Trainer2.regular_character = true
		$Trainer2.trainer_npc = false
		$Trainer.trainer_npc = false
	elif room == 18:
		$Trainer.number_of_character_in_dialogue = "24"
		$Trainer2.number_of_character_in_dialogue = "25"
		$Trainer.regular_character = true
		$Trainer2.regular_character = true
		$Trainer2.trainer_npc = false
		$Trainer.trainer_npc = false
		

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

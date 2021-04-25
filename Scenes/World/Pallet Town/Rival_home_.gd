extends Node2D


onready var scene = load("res://Scenes/World/Pallet Town.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.is_in[0]="PalletTown"
	$Door.next_scene = scene
	if PlayerData.first_time!=true and PlayerData.first_time_viridian!=true and PlayerData.got_pokedex==true:
		$NPC.number_of_character_in_dialogue="Rival's Sis 2"
		$NPC.regular_character=false
		$NPC.receive_gift_from_npc=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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

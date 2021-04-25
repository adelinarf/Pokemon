extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
onready var scene = load("res://Scenes/World/Pallet Town.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.is_in[0]="PalletTown"
	PlayerData.is_in[1]="res://Scenes/World/Pallet Town/Oak's_Lab_.tscn"
	$Door.next_scene = scene
	if PlayerData.first_time == true:
		$Select_first_pokemon.set_process_unhandled_input(false)
		$Rival.position=Vector2(280,184)
	else:
		$Select_first_pokemon.free()
		#$getting_out.free()
		$Timer.free()
		if PlayerData.first_time_viridian==true:
			$Oak.number_of_character_in_dialogue = "Oak"
			$Rival.free()
		elif PlayerData.first_time_viridian==false:
			$Oak.number_of_character_in_dialogue = "Oak_parcel"
			$Rival.visible=true
			$Rival.position=Vector2(360,1055.72)
			$Rival.number_of_character_in_dialogue = "Getting_pokedex"
onready var collision= get_node("getting_out/CollisionShape2D")
func _process(delta):
	if $player.position.y>=375 and PlayerData.first_time==true:
		$getting_out.collision_layer=1
	elif $player.position.y<375 and PlayerData.first_time==true:
		$getting_out.collision_layer=2
	elif PlayerData.first_time==false:
		$getting_out.collision_layer=1

func _on_getting_out_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		PlayerData.colliding_character = "Oak_attempt_leaving"
		PlayerData.is_colliding_with = 4
		$Select_first_pokemon.set_process_unhandled_input(false)
		#$Dialog_box/WindowDialog.popup()
		
func _on_getting_out_area_exited(area: Area2D) -> void:
	PlayerData.is_colliding_with = null
	#$Select_first_pokemon.set_process_unhandled_input(false)

var choose=null
var is_done = null
func _on_Select_first_pokemon_choose(value) -> void:
	is_done=value
	print (is_done,"HERE IT IS")
	if choose == null and value == true and $Oak.number_of_character_in_dialogue=="Getting_pokemon":
		is_done=null
		$Select_first_pokemon.set_process_unhandled_input(false)
		$Rival/AnimationPlayer.play("walk")
		choose = value
		PlayerData.colliding_character = "After_getting_pokemon"
		$Oak.number_of_character_in_dialogue = "After_getting_pokemon"
		$Oak.regular_character = false
		$Oak.trainer_npc = true
		$Rival.regular_character = false
		$Rival.trainer_npc = true
		$Rival.number_of_character_in_dialogue = "After_getting_pokemon"
		PlayerData.is_in[1] = "res://Scenes/World/Pallet Town/Oak's_Lab_.tscn"
		PlayerData.is_in[2] = $player.position
		PlayerData.first_time = false
		$Timer.set_wait_time(4)
	#$Timer.start()
	elif choose == null and value == false:
		$Select_first_pokemon.set_process_unhandled_input(false)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$Rival/AnimationPlayer.stop()
	if anim_name=="walk down":
		$Rival.free()
		
		
func _on_Timer_timeout() -> void:
	#print (PlayerData.is_colliding_with)
	self.set_process_unhandled_input(true)
	PlayerData.is_in[1] = "res://Scenes/World/Pallet Town/Oak's_Lab_.tscn"
	PlayerData.is_in[2] = $player.position
	PlayerData.first_time = false
	
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
	elif body.name == "Inside objects2":
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
	if value == true and PlayerData.first_time == false and PlayerData.first_time_viridian==false:
		if PlayerData.colliding_character == "Oak_parcel":
			$Rival/AnimationPlayer.current_animation = "walk up"
			$Rival.visible=true
			$Rival/AnimationPlayer.play()
			$player._on_player_area_entered($Rival)
		elif PlayerData.colliding_character== "Getting_pokedex":
			$Rival/AnimationPlayer.current_animation = "walk down"
			$Rival/AnimationPlayer.play()
			$Oak.number_of_character_in_dialogue = "Oak_pokedex"
			PlayerData.colliding_character = "Oak_pokedex"
			#$player._on_player_area_entered($Oak)
			PlayerData.got_pokedex=true

	
func _on_Oaks_Lab_tree_exiting():
	if PlayerData.first_time == false:
		PlayerData.is_in[1]="res://Scenes/World/Pallet Town/Oak's_Lab_animations.tscn"

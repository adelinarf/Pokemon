extends Node2D

var viridian_city = load("res://Scenes/World/Viridian City.tscn")
var pewter_city = load("res://Scenes/World/Pewter City.tscn")
var route4 = load("res://Scenes/World/Routes/Route 4.tscn")
var cerulean_city = load("res://Scenes/World/Cerulean City.tscn")
var vermilion_city = load("res://Scenes/World/Vermilion City.tscn")
var lavender_town = load("res://Scenes/World/Lavender Town.tscn")
var celadon_city = load("res://Scenes/World/Celadon City.tscn")
var saffron_city = load("res://Scenes/World/Saffron City.tscn")
var inside=PlayerData.is_in[0]

func _ready():
	select_dialogue()
	PlayerData.is_in[1]="res://Scenes/World/Viridian City/Mall.tscn"

func select_dialogue():
	if inside=="ViridianCity":
		PlayerData.current_dialogue = PlayerData.dialogue.viridian_city
		$Door.next_scene = viridian_city
		$NPC3.free()
	elif inside=="CeruleanCity":
		PlayerData.current_dialogue = PlayerData.dialogue.cerulean_city
		$Door.next_scene = cerulean_city
		$NPC3.free()
	elif inside=="LavenderTown":
		PlayerData.current_dialogue = PlayerData.dialogue.lavender_town
		$Door.next_scene = lavender_town
		$NPC3.free()
	elif inside=="PewterCity":
		PlayerData.current_dialogue = PlayerData.dialogue.pewter_city
		$Door.next_scene = pewter_city
		$NPC3.free()
	elif inside =="VermilionCity":
		$NPC.number_of_character_in_dialogue = "Mart 2"
		$NPC2.number_of_character_in_dialogue = "Mart 3"
		$NPC3.number_of_character_in_dialogue = "Mart 1"
		PlayerData.current_dialogue = PlayerData.dialogue.vermilion_city
		$Door.next_scene = vermilion_city
	elif inside=="SaffronCity":
		PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
		if PlayerData.defeated_team_rocket==false:
			pass
		elif PlayerData.defeated_team_rocket==true:
			$NPC.number_of_character_in_dialogue += " after"
			$NPC2.number_of_character_in_dialogue += " after"
			$NPC3.number_of_character_in_dialogue += " after"
		$Door.next_scene = saffron_city

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

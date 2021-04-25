extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
signal choose(value)
onready var show_pokemon = get_node("Rect_Text")
var chosen = false setget set_chosen
# Called when the node enters the scene tree for the first time.
var ball=1
var scratch = {
		"accuracy": 100, 
		"category": "\u7269\u7406", 
		"cname": "\u5229\u722a", 
		"ename": "Scratch", 
		"id": 10, 
		"jname": "\u3072\u3063\u304b\u304f", 
		"power": 40, 
		"pp": 35, 
		"type": "Normal"
	}
var growl = {
		"accuracy": 100, 
		"category": "\u53d8\u5316", 
		"cname": "\u568e\u53eb", 
		"ename": "Growl", 
		"id": 45, 
		"jname": "\u306a\u304d\u3054\u3048", 
		"power": null, 
		"pp": 40, 
		"type": "Normal"
	}
var tackle = {
		"accuracy": 100, 
		"category": "\u7269\u7406", 
		"cname": "\u4f0f\u7279\u653b\u51fb", 
		"ename": "Volt Tackle", 
		"id": 344, 
		"jname": "\u30dc\u30eb\u30c6\u30c3\u30ab\u30fc", 
		"power": 120, 
		"pp": 15, 
		"type": "Electric"
	}
var tail_whip = {
		"accuracy": 100, 
		"category": "\u53d8\u5316", 
		"cname": "\u6447\u5c3e\u5df4", 
		"ename": "Tail Whip", 
		"id": 39, 
		"jname": "\u3057\u3063\u307d\u3092\u3075\u308b", 
		"power": null, 
		"pp": 30, 
		"type": "Normal"
	}
onready var sprite = get_node("Rect_Text/Sprite")
var ball1 = ["Charmander",5,"Blaze",[scratch,growl],4]
var ball2 = ["Squirtle", 5, "Torrent", [tackle, tail_whip],7]
var ball3 = ["Bulbasaur", 5, "Overgrow", [tail_whip, growl],1]
var balls=[ball1,ball2,ball3]
var name_ = balls[ball-1][0]
var level = balls[ball-1][1]
var ability = balls[ball-1][2]
var moves = balls[ball-1][3][0]["ename"] + " and " + balls[ball-1][3][1]["ename"]

func _ready() -> void:
	$two_option_menu.visible =false
	show_pokemon.visible = false
	self.set_process_internal(false)
	self.set_process_unhandled_input(false)
	
func _process(delta: float) -> void:
	name_ = balls[ball-1][0]
	level = balls[ball-1][1]
	ability = balls[ball-1][2]
	moves = balls[ball-1][3][0]["ename"] + " and " + balls[ball-1][3][1]["ename"]
	if ball==1:
		get_info(ball)
	elif ball==2:
		get_info(ball)
	elif ball==3:
		get_info(ball)

#PlayerData.newpokemon(name, level, HP, movements, experience,nickname)
func get_info(ball):
	var id = balls[ball-1][4]
	PlayerData.set_pokemon_sprite(sprite,id,false)
	$Rect_Text/name.text = name_
	$Rect_Text/level.text = String(level)
	$Rect_Text/Ability.text = ability
	$Rect_Text/Moves.text = moves

func set_chosen(value):
	chosen = value
	emit_signal("choose",chosen)

		
func visibles(value):
	self.set_process_internal(value)
	self.set_process_unhandled_input(value)
	show_pokemon.visible = value
	$two_option_menu.visible = value

func _on_Ball_1_area_entered(area: Area2D) -> void:
	visibles(true)
	ball=1

func _on_Ball_2_area_entered(area: Area2D) -> void:
	visibles(true)
	ball=2

func _on_Ball_3_area_entered(area: Area2D) -> void:
	visibles(true)
	ball=3
	
func set_rival_pokemon():
	var rival_pokemon=[]
	if ball==1:
		rival_pokemon = [balls[1][0],balls[1][1]]
		PlayerData.pokemon_rival = balls[0][0]
	elif ball ==2:
		rival_pokemon = [balls[2][0],balls[2][1]]
		PlayerData.pokemon_rival = balls[1][0]
	elif ball ==3:
		rival_pokemon = [balls[0][0],balls[0][1]]
		PlayerData.pokemon_rival = balls[2][0]
	print (PlayerData.pokemon_rival)
	PlayerData.rival[0]["Pokemon"].append(rival_pokemon)
	#PlayerData.current_trainer = PlayerData.rival[0]

func _on_two_option_menu_is_pressed(value) -> void:
	if value ==0 and show_pokemon.visible ==true and $two_option_menu.visible==true:
		var HP = (PlayerData.get_pokemon_info_by_name(name_))[2]["HP"]
		PlayerData.newpokemon(name_, level, HP, balls[ball-1][3], 1300,"")
		self.chosen = true
		visibles(false)
		set_rival_pokemon()
		self.queue_free()
	elif value ==1 and show_pokemon.visible ==true and $two_option_menu.visible==true:
		visibles(false)

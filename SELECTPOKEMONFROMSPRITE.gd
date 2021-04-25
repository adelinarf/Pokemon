extends Node2D

#var sprite = load("res://assets/pokemon_battle/battle_beggining/pokemons.tres")
#export var id = 55
var on_fight_player = false
var on_fight_enemy = true
var id1 = 1
var id2 = 50
onready var sprite1 = get_node("Sprite2")
onready var sprite2 = get_node("Sprite3")
"""
func select_pokemon_second_sprite():
	$Sprite3.texture = sprite2
	var aumentoenx = 32 * ((id +2) % 3)
	var numerofila = 0
	var aumentoeny = 96 * numerofila
	var quantity =null
	if id % 3 == 1:
		quantity = id
	elif id % 3 == 0:
		quantity = id -2
	elif id % 3 == 2:
		quantity = id - 1
	var multiplier = (quantity - 1) / 15
	var number = 0
	var iteration = 0
	for x in range(51):
		number = quantity - 3
		iteration += 1
		if number == 1:
			break
		else:
			pass
	numerofila = iteration
	sprite2.set_region(Rect2(0+aumentoenx,24+aumentoeny,298.111,66.288))
	$Sprite3.hframes = 4
	$Sprite3.vframes = 1
	var position = null
	if on_fight_player == true:
		position = 2
	if on_fight_enemy == true:
		position = 0
	$Sprite3.frame = position
"""
func _ready() -> void:
	process(sprite1,id1,true)
	process(sprite2,id2,false)
	
func process(SPRITE,id,on_fight_player):
	var sprite_ = load("res://assets/pokemon_battle/battle_beggining/pokemons.tres")
	var sprite = sprite_.duplicate()
	SPRITE.texture = sprite
	var x=164
	var multiplier = ceil(id/15.0)-1
	print ("Multiplier",multiplier)
	var quantity = (15 * multiplier) + 1
	print ('Quantity',quantity)
	sprite.set_region(Rect2(10.571,43.95+x*multiplier,1950.353,130.486))
	SPRITE.hframes = 30
	SPRITE.vframes = 2	
	var position = null
	if on_fight_player == true:
		position = (id - quantity) * 2 + 30
	if on_fight_enemy == true:
		position = (id - quantity) * 2
	print (position,"POSITION")
	SPRITE.frame = position	


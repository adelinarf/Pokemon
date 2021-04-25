extends Node2D

#var sprite = load("res://assets/pokemon_battle/battle_beggining/pokemons.tres")
#export var id = 55
var id1 = 1
var id2 = 50
onready var sprite1 = get_node("Sprite2")
onready var sprite2 = get_node("Sprite3")

func _ready() -> void:
	process(sprite1,120)
	process(sprite2,1)
	
func process(SPRITE,id):
	var sprite_ = load("res://assets/pokemon_battle/battle_beggining/pokemons.tres")
	var sprite = sprite_.duplicate()
	SPRITE.texture = sprite
	var x=130
	var y = 165
	var rows = ceil(id/15.0)-1
	print (rows)
	var first_element = (15 * rows) + 1
	print (first_element)
	var columns = id - first_element
	print (columns)
	SPRITE.region_rect = (Rect2(30+x*rows,15+y*columns,160,20))
	#sprite.set_region(Rect2(44+x*rows,20+y*columns,70,30))
	SPRITE.hframes = 2
	SPRITE.vframes = 1	
	SPRITE.frame = 0	


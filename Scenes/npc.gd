extends Area2D

export var character = 0
export var number_of_character_in_dialogue = ""
export var direction = "down"
export var heal_pokemon = false
export var collide_pc = false
export var trainer_npc = false
export var receive_gift_from_npc = false
export var regular_character = false
export var mall_character = false
export var advice_character = false
#var sprite_ = load("res://assets/heroes_and_npc/npc.tres")
#var sprite = sprite_.duplicate()
#onready var SPRITE = get_node("Sprite2")
var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon","Do you wanna heal your pokemon?"]
#var dialog = ["You turned on the PC","Which PC do you wanna access?"]
#var dialog = ["I'm so much better than you","I wanna show you how"]
#var dialog = ["I got this magic powder", "It can make pokemons go up in level faster","Do you want it?"]
#var dialog = ["I'm just a normal character", "Guiding you through pokemon story"]
#var dialog = ["Welcome to the pokemall","Here we have everything for your pokemon","Can we help you?"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if direction == "down":
		$AnimatedSprite.animation = String(character) + " down"
	elif direction=="left":
		$AnimatedSprite.animation = String(character) + " left"
	elif direction=="up":
		$AnimatedSprite.animation = String(character) + " up"
	if number_of_character_in_dialogue =="Oak":
		$CollisionPolygon2D.scale = Vector2(2,2)


func _on_NPC_area_entered(area: Area2D) -> void:
	PlayerData.colliding_character = String(number_of_character_in_dialogue)
	print("IS BEING HIT")
	if area.is_in_group("player"):
		if heal_pokemon == true:
			PlayerData.is_colliding_with = 0
		elif collide_pc == true:
			PlayerData.is_colliding_with = 1
		elif trainer_npc == true:
			PlayerData.is_colliding_with = 2
		elif receive_gift_from_npc == true:
			PlayerData.is_colliding_with = 3
		elif regular_character == true:
			PlayerData.is_colliding_with = 4
		elif mall_character == true:
			PlayerData.is_colliding_with = 5
		elif advice_character==true:
			PlayerData.is_colliding_with = 6
		print("DONT TOUCHE ME")
		#print (PlayerData.colliding_character)

func _on_NPC_area_exited(area: Area2D) -> void:
	pass #PlayerData.is_colliding_with = null
	#print ("AS I WANT LEAVE DUDE")

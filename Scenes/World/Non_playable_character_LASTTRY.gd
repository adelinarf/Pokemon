extends Node2D
#
#var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon"]
#var dialog = ["You turned on the PC","Which PC do you wanna access?"]
#var dialog = ["I'm so much better than you","I wanna show you how"]
var dialog = ["I got this magic powder", "It can make pokemons go up in level faster"]
var dialog_string = 0
var dialog_number = 0 
var collide = false
export var number_of_character = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
onready var dialog_box = get_node("AcceptDialog")
func change_dialog():
	if collide == true:
		if Input.is_action_just_pressed("ui_accept"):
			dialog_box.pause_mode = true
			dialog_box.popup()
			if dialog_number >= len(dialog):
				if number_of_character == 0:  #Pokemon center
					dialog_box.dialog_text = "Do you wanna heal your pokemon?"
				elif number_of_character == 1:  #PC
					dialog_box.dialog_text = "What PC do you wanna access to?"
					$ItemList.visible = true
					$ItemList.clear()
					$ItemList.add_item(String(PlayerData.player_test["name"])+"'s"+" PC")
					$ItemList.add_item("Bill's PC")
					$ItemList.add_item("Prof. Oak's PC")
					$ItemList.add_item("Exit")
				elif number_of_character == 2:  #Trainers
					pass #START THE FIGH WITH THE TRAINER CON UNA FUNCION 
					#PERO AUN NO ESTA LISTA ESA FUNCION
				elif number_of_character == 3:  #People that give you things
					dialog_box.dialog_text = "Do you want it?"
					$ItemList.visible = true
					$ItemList.clear()
					$ItemList.add_item("Yes")
					$ItemList.add_item("No")
					$ItemList.add_item("Exit")	
				else:
					pass
			else:
				dialog_box.dialog_text = dialog[(dialog_number)%len(dialog)]
				dialog_number += 1
	else:
		dialog_number = 0
				
func _process(delta: float) -> void:
	change_dialog()

func _on_Character_area_entered(area: Area2D) -> void:
	collide = true

func _on_Character_area_exited(area: Area2D) -> void:
	collide = false
	dialog_number = 0
var d = ["Do you wanna heal your pokemon?","We're healing your pokemon","Be back when you need us"]

func _on_AcceptDialog_confirmed() -> void:
	if dialog_number >= len(dialog) and number_of_character == 0:
		dialog_box.popup()
		PlayerData.heal_pokemon()
		for x in range(len(d)):   #ESTO FUNCIONA PERO NECESITA UN TIMER
			if dialog_box.dialog_text == d[x] and (x+1)<len(d):
				dialog_box.dialog_text = d[x+1]
		#dialog_box.dialog_text = "Be back when you need us"
		if dialog_box.dialog_text == d[len(d)-1]:
			dialog_box.hide()

var dia = ["What PC do you wanna access to?","You have accesed Oak's PC", "Accessing system of evaluation of Pokedex"]

func _on_ItemList_item_selected(index: int) -> void:
	var name = $ItemList.get_item_text(index)
	dialog_box.popup()
	if name == String(PlayerData.player_test["name"])+"'s"+" PC":
		pass # HACER OTRA ESCENA BASADA EN BAG
	elif name == "Bill's PC":
		pass # HACER OTRA ESCENA 
	elif name == "Prof. Oak's PC":
		dialog_box.popup()
		dialog_box.visible = true
		for x in range(len(dia)):   #ESTO FUNCIONA PERO NECESITA UN TIMER
			if dialog_box.dialog_text == dia[x] and (x+1)<len(dia):
				dialog_box.dialog_text = dia[x+1]
		var pokemon = len(PlayerData.player_test["Pokedex"])
		var number_seen_pokemon = 10
		dialog_box.dialog_text = "You have captured " + String(pokemon) + "and have seen " + String(number_seen_pokemon)
		if pokemon < 50:
			dialog_box.dialog_text = "You need to keep capturing pokemon"
		elif 50 < pokemon < 100:
			dialog_box.dialog_text = "Keep on capturing pokemon"
		else:
			dialog_box.dialog_text = "You're a great trainer, keep capturing pokemon"
		$ItemList.visible = false
	elif name == "Yes":
		$ItemList.visible = false
		dialog_box.dialog_text = "This will be very helpful"
	elif name == "No":
		dialog_box.dialog_text = "You'll be back for it"
		$ItemList.visible = false
	else:
		$ItemList.visible = false
		dialog_box.hide()


func _on_AcceptDialog_custom_action() -> void:
	pass # Replace with function body.

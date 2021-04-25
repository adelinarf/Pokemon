extends Node2D

onready var dialog_box = get_node("WindowDialog")
onready var dialog_text = get_node("WindowDialog/Label")
# Called when the node enters the scene tree for the first time.
var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon","Do you wanna heal your pokemon?"]
#var dialog = ["You turned on the PC","Which PC do you wanna access?"]
#var dialog = ["I'm so much better than you","I wanna show you how"]
#var dialog = ["I got this magic powder", "It can make pokemons go up in level faster","Do you want it?"]
#var dialog = ["I'm just a normal character", "Guiding you through pokemon story"]
#var dialog = ["Welcome to the pokemall","Here we have everything for your pokemon","Can we help you?"]
var dialog_number = 0

func _ready() -> void:
	dialog_text.text = dialog[0]
	$WindowDialog/GridContainer2/Player_PC.text = PlayerData.player_test["name"] + "'s " + "PC"
	$WindowDialog/GridContainer.visible = false
	$WindowDialog/GridContainer2.visible = false
	#$WindowDialog.popup()
func _process(delta: float) -> void:
	change_dialog()
	
func change_dialog():
	if PlayerData.is_colliding_with!=null and Input.is_action_just_pressed("ui_accept"):
		dialog_box.pause_mode = true
		dialog_box.popup()
var is_pressed = null
var dialog1 = ["Be back when you need us"]

#THIS USES KEYS the other one is with the mouse
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var number = 0
		if dialog_number >= len(dialog):
			if PlayerData.is_colliding_with == 0:
				$WindowDialog/GridContainer.visible = true
				if is_pressed == "Yes":
					$WindowDialog/GridContainer.visible = false
					number = show_dialog(dialog1,number)
				elif is_pressed == "No":
					$WindowDialog/GridContainer.visible = false
			elif PlayerData.is_colliding_with == 1:
				$WindowDialog/GridContainer2.visible = true
				if is_pressed != null:
					$WindowDialog/GridContainer2.visible = false
			elif PlayerData.is_colliding_with == 2:
				get_tree().change_scene("res://Scenes/Battle_beggining.tscn")
			elif PlayerData.is_colliding_with == 3:
				$WindowDialog/GridContainer.visible = true
				if is_pressed == "Yes":
					$WindowDialog/GridContainer.visible = false
				elif is_pressed == "No":
					$WindowDialog/GridContainer.visible = false
			elif PlayerData.is_colliding_with == 4:
				dialog_number = 0
			elif PlayerData.is_colliding_with == 5: #MALL
				$WindowDialog/GridContainer.visible = true
				if is_pressed == "Yes":
					$WindowDialog/GridContainer.visible = false
				elif is_pressed == "No":
					$WindowDialog/GridContainer.visible = false
				
		else:
			dialog_text.text = dialog[dialog_number]
			dialog_number += 1

func _on_Next_pressed() -> void:
	var number = 0
	if dialog_number >= len(dialog):
		if PlayerData.is_colliding_with == 0:
			$WindowDialog/GridContainer.visible = true
			if is_pressed == "Yes":
				$WindowDialog/GridContainer.visible = false
				number = show_dialog(dialog1,number)
			elif is_pressed == "No":
				$WindowDialog/GridContainer.visible = false
		elif PlayerData.is_colliding_with == 1:
			$WindowDialog/GridContainer2.visible = true
			if is_pressed != null:
				$WindowDialog/GridContainer2.visible = false
		elif PlayerData.is_colliding_with == 2:
			get_tree().change_scene("res://Scenes/Battle_beggining.tscn")
		elif PlayerData.is_colliding_with == 3:
			$WindowDialog/GridContainer.visible = true
			if is_pressed == "Yes":
				$WindowDialog/GridContainer.visible = false
			elif is_pressed == "No":
				$WindowDialog/GridContainer.visible = false
		elif PlayerData.is_colliding_with == 4:
			dialog_number = 0
		elif PlayerData.is_colliding_with == 5: #MALL
			$WindowDialog/GridContainer.visible = true
			if is_pressed == "Yes":
				$WindowDialog/GridContainer.visible = false
			elif is_pressed == "No":
				$WindowDialog/GridContainer.visible = false
			
	else:
		dialog_text.text = dialog[dialog_number]
		dialog_number += 1

func show_dialog(d,number)->int:
	if number >= len(dialog):
		dialog_box.hide()
	else:
		dialog_text.text = d[number]
		number += 1
	return (number)
func _on_Yes_pressed() -> void:
	is_pressed = "Yes"
	$WindowDialog/GridContainer.visible = false
	if PlayerData.is_colliding_with == 0:
		PlayerData.heal_pokemon()
		dialog_text.text = "We're healing your pokemon"
	if PlayerData.is_colliding_with == 3:
		#ADD A FUNCTION TO ADD ITEM TO BAG
		dialog_text.text = "This will be very helpful"
	if PlayerData.is_colliding_with == 5:
		get_tree().change_scene("res://Scenes/UI components/Mall.tscn")
	#dialog_number = 0

func _on_No_pressed() -> void:
	is_pressed = "No"
	$WindowDialog/GridContainer.visible = false
	if PlayerData.is_colliding_with == 0:
		dialog_text.text = "Be back when you need us"
	if PlayerData.is_colliding_with == 3:
		dialog_text.text = "You'll be back for it"
	if PlayerData.is_colliding_with == 5:
		dialog_text.text = "Come back when you need something"
	#dialog_number = 0
		
func _on_Player_PC_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/PlayerPC.tscn")

func _on_Bill_PC_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/BillPC.tscn")
	
func _on_Oak_PC_pressed() -> void:
	is_pressed = "Oak"
	$WindowDialog/GridContainer2.visible = false
	var pokemon = len(PlayerData.player_test["Pokedex"])
	var number_seen_pokemon = 10
	dialog_text.text = "You have captured " + String(pokemon) + " pokemon "+ "\n and have seen " + String(number_seen_pokemon) + " pokemon"
	var more_text = ""
	if pokemon < 50:
		more_text = "\n You need to keep \n capturing pokemon"
	elif 50 < pokemon < 100:
		more_text = "\n Keep on capturing pokemon"
	else:
		more_text = "\n You're a great trainer, \n keep capturing pokemon"
	dialog_text.text += more_text
	dialog_number = 0

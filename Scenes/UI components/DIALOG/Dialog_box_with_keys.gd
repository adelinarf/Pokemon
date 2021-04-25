extends Node2D

onready var dialog_box = get_node("WindowDialog")
onready var dialog_text = get_node("WindowDialog/Label")
# Called when the node enters the scene tree for the first time.
#var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon","Do you wanna heal your pokemon?"]
onready var menu_selection = get_node("Menu_rpg/GridContainer")
#var dialog = ["You turned on the PC","Which PC do you wanna access?"]
#var dialog = ["I'm so much better than you","I wanna show you how"]
#var dialog = ["I got this magic powder", "It can make pokemons go up in level faster","Do you want it?"]
#var dialog = ["I'm just a normal character", "Guiding you through pokemon story"]
#var dialog = ["Welcome to the pokemall","Here we have everything for your pokemon","Can we help you?"]
var dialog_container = PlayerData.find_npc_dialogue()
var dialog = dialog_container["Dialogue"]
var object = dialog_container["Object"]
var dialog_number = 0
var successfully_received = ""
var too_much_items = ""
var visible_menu = false
signal is_ready(value)
var ready = false setget set_ready

func _ready() -> void:
	dialog_text.text = dialog[0]
	menu_selection.visible = false
	#$WindowDialog.popup()
func _process(delta: float) -> void:
	change_dialog()
	$two_option_menu.visible = visible_menu
	
func set_ready(value):
	ready = value
	emit_signal("is_ready",ready)
	
func change_dialog():
	dialog_container = PlayerData.find_npc_dialogue()
	dialog = dialog_container["Dialogue"]
	object = dialog_container["Object"]
	if PlayerData.is_colliding_with ==3:
		successfully_received = dialog.pop_back()
		too_much_items = dialog.pop_back()
	if PlayerData.is_colliding_with!=null and Input.is_action_just_pressed("ui_accept"):
		#dialog_box.pause_mode = true
		dialog_box.popup_centered_clamped()
var is_pressed = null
var dialog1 = ["Be back when you need us"]
#THIS USES KEYS the other one is with the mouse
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var number = 0
		if dialog_number >= len(dialog):
			if PlayerData.is_colliding_with == 0:
				menu_selection.visible = true
				visible_menu = true
				if is_pressed == "Yes":
					menu_selection.visible = false
					number = show_dialog(dialog1,number)
				elif is_pressed == "No":
					menu_selection.visible = false
			elif PlayerData.is_colliding_with == 1:
				menu_selection.visible = true
				if is_pressed != null:
					menu_selection.visible = false
			elif PlayerData.is_colliding_with == 2:
				get_tree().change_scene("res://Scenes/Battle_beggining.tscn")
			elif PlayerData.is_colliding_with == 3:
				menu_selection.visible = true
				visible_menu = true
				if is_pressed == "Yes":
					menu_selection.visible = false
				elif is_pressed == "No":
					menu_selection.visible = false
			elif PlayerData.is_colliding_with == 4:
				dialog_number = 0
				self.ready = true
			elif PlayerData.is_colliding_with == 5: #MALL
				menu_selection.visible = true
				visible_menu = true
				if is_pressed == "Yes":
					menu_selection.visible = false
				elif is_pressed == "No":
					menu_selection.visible = false
			elif PlayerData.is_colliding_with == 6:
				dialog_number = len(dialog)-1
				dialog_box.hide()
		else:
			dialog_text.text = dialog[dialog_number]
			dialog_number += 1
	if event.is_action_pressed("space"):
		if dialog_text.text == dialog[len(dialog)-1]:
			dialog_box.visible = false
			menu_selection.visible=false
			visible_menu = false
		if PlayerData.is_colliding_with == 3:
			dialog_box.visible = false
			menu_selection.visible=false
			visible_menu = false
		if PlayerData.is_colliding_with == 0:
			if dialog_text.text == "Be back when you need us" or dialog_text.text == "We're done come back when you need us":
				dialog_box.visible = false
				menu_selection.visible=false
				visible_menu = false

func show_dialog(d,number)->int:
	if number >= len(dialog):
		dialog_box.hide()
	else:
		dialog_text.text = d[number]
		number += 1
	return (number)
func _on_Yes_pressed() -> void:
	is_pressed = "Yes"
	menu_selection.visible = false
	visible_menu = false
	if PlayerData.is_colliding_with == 0:
		PlayerData.heal_pokemon()
		dialog_text.text = "We're healing your pokemon"
	if PlayerData.is_colliding_with == 3:
		#ADD A FUNCTION TO ADD ITEM TO BAG
		dialog_text.text = successfully_received
	if PlayerData.is_colliding_with == 5:
		get_tree().change_scene("res://Scenes/UI components/Mall.tscn")
	#dialog_number = 0

func _on_No_pressed() -> void:
	is_pressed = "No"
	menu_selection.visible = false
	visible_menu = false
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

func oaks():
	menu_selection.visible = false
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
	
func nos():
	menu_selection.visible = false
	visible_menu = false
	if PlayerData.is_colliding_with == 0:
		dialog_text.text = "Be back when you need us"
	if PlayerData.is_colliding_with == 3:
		dialog_text.text = "You'll be back for it"
	if PlayerData.is_colliding_with == 5:
		dialog_text.text = "Come back when you need something"
func yes():
	menu_selection.visible = false
	visible_menu = false
	if PlayerData.is_colliding_with == 0:
		$Timer.set_wait_time(4)
		$Timer.start()
		dialog_text.text = "We're healing your pokemon"
		PlayerData.heal_pokemon()
		#if Input.is_action_just_pressed("ui_accept"):
			#dialog_text.text = "We're done come back when you need us"
	if PlayerData.is_colliding_with == 3:
		#if object[0] == null or object[1]==null or object[2]==null:
			#pass
		#else:
		for i in range(len(PlayerData.player_test["Bag"][0]["Content"])):
			if PlayerData.player_test["Bag"][object[0]]["Content"][i][0] == object[1]:
				PlayerData.player_test["Bag"][object[0]]["Content"][i][1] += object[2]
		dialog_text.text = successfully_received
	if PlayerData.is_colliding_with == 5:
		get_tree().change_scene("res://Scenes/UI components/Mall.tscn")
		
func _on_Menu_rpg_pressed(value) -> void:
	if value == "Yes":
		yes()
	if value == "No":
		nos()
	if value == PlayerData.player_test["name"] + "'s PC":
		get_tree().change_scene("res://Scenes/UI components/PlayerPC.tscn")
	if value == "Bill's PC":
		get_tree().change_scene("res://Scenes/UI components/BillPC.tscn")
	if value == "Oak's PC":
		oaks()


func _on_two_option_menu_is_pressed(value) -> void:
	if value == 0:
		yes()
	elif value == 1:
		nos()

func _on_Timer_timeout() -> void:
	dialog_text.text = "We're done come back when you need us"

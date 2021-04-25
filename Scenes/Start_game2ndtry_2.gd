extends Control


onready var dialog = get_node("Dialog_box")
onready var two_menu = get_node("two_option_menu")
onready var popdialog=get_node("CanvasLayer/Dialog_box/WindowDialog")


func _ready() -> void:
	if PlayerData.player_test["Sprite"] == 0:
		$character.frame = 7
	elif PlayerData.player_test["Sprite"] ==1:
		$character.frame = 8 
	var charac = "Right! So your name is " + PlayerData.player_test["name"] + "?"
	dialog.dialog = [charac]
	dialog.get_node("WindowDialog/Label").text = charac
	PlayerData.is_colliding_with = 6
	dialog.get_node("WindowDialog").popup()
	two_menu.visible = true
	two_menu.get_node("menu/Yes").text = "Yes"
	two_menu.get_node("menu/No").text = "No"
	PlayerData.colliding_character = "2"
	PlayerData.is_colliding_with = 4
	
	pass #PlayerData.connect("player_data_updated",self,"update_interface")
	 #update_interface()
var rival = false
func _process(delta: float) -> void:
	pass
	
	if dialog.get_node("WindowDialog/Label").text == dialog.dialog[len(dialog.dialog)-1]:
		two_menu.visible = true
		if rival == true:
			two_menu.get_node("menu/Yes").text = "Blue"
			two_menu.get_node("menu/No").text = "Bosco"
		#	popdialog.is_visible_in_tree()
		#if confirmation == true:
			#two_menu.visible = true
	 

var pressed = null
func _on_two_option_menu_is_pressed(value) -> void:
	pressed = value
	print (pressed,"PRESSED")
	if pressed == 0 and rival == false:
		$character.frame = 2
		rival=true
		two_menu.visible = false
	if pressed == 1 and rival == false:
		get_tree().change_scene("res://Scenes/UI components/Menu_naming.tscn")
	var rivalname = "Rival"
	if pressed == 0 and rival == true:
		rivalname = "Blue"#
	elif pressed == 1 and rival == true:
		rivalname = "Bosco"
	two_menu.visible = false
	#dialog.get_node("WindowDialog/Label").text = "That's right! I remember now! His name is" + rivalname + "!"
	#dialog.dialog = ["That's right! I remember now! His name is " + rivalname + "!", PlayerData.player_data["name"]+" ! Your very own POKEMON legend is about to unfold! A world of dreams and adventures with POKEMON awaits! Let's go!"]
	if dialog.get_node("WindowDialog/Label").text == dialog.dialog[len(dialog.dialog)-1]:
		two_menu.visible = false
		#dialog.dialog = ["That's right! ","That's right! I remember now! His name is " + rivalname + "!", PlayerData.player_test["name"]+" ! Your very own POKEMON legend is about to unfold! A world of dreams \n and adventures with POKEMON awaits! Let's go!"]
		var a = ["That's right! ","That's right! I remember now! His name is " + rivalname + "!", PlayerData.player_test["name"]+" ! Your very own POKEMON legend is about to unfold! A world of dreams \n and adventures with POKEMON awaits! Let's go!"]
		if dialog.get_node("WindowDialog/Label").text == a[len(a)-1]:
			two_menu.visible = false
			print ("ESTA ENTRANDO AQUI")
			exit = true
			
func next_dialogues():
	pass
	#dialog.dialog =["This is my grandson. He's been your rival since you were a baby.","...Erm, what is his name again?"]	
			
var exit = false
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and exit == true:
		get_tree().change_scene("res://Scenes/UI components/Bag.tscn")

func _on_Dialog_box_is_ready(value) -> void:
	PlayerData.player_test["id"]=PlayerData.player_id()
	get_tree().change_scene("res://Scenes/World/Pallet Town.tscn")

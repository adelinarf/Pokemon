extends Control


onready var dialog = get_node("Dialog_box")
onready var two_menu = get_node("two_option_menu")
onready var popdialog=get_node("Dialog_box/WindowDialog")


func _ready() -> void:
	dialog.dialog = ["Hello there! Welcome to the world of POKEMON! My name is OAK! People call me the POKEMON PROF!", "This world is inhabited by creatures called POKEMON! For some people, POKEMON are pets. Others use them for fights. Myself... I study POKEMON as a profession.", "Now tell me are you a boy or a girl?"]
	PlayerData.is_colliding_with = 6
	two_menu.get_node("menu/Yes").text = "Boy"
	two_menu.get_node("menu/No").text = "Girl"
	
	pass #PlayerData.connect("player_data_updated",self,"update_interface")
	 #update_interface()
	
var decide = true
var naming = false
var confirmation = false
func _process(delta: float) -> void:
	if dialog.get_node("WindowDialog/Label").text == dialog.dialog[len(dialog.dialog)-1]:
		if decide == true:
			two_menu.visible = true
		if naming == true:
			popdialog.is_visible_in_tree()
		if confirmation == true:
			two_menu.visible = true

var pressed = null
func _on_two_option_menu_is_pressed(value) -> void:
	pressed = value
	if pressed == 0 and decide == true:
		PlayerData.player_data["Sprite"] = 0
	elif pressed == 1 and decide == true:
		PlayerData.player_data["Sprite"] = 1
	if pressed == 0 and confirmation == true:
		pass
	elif pressed==1 and confirmation ==true:
		$Menu_naming.visible = true
	if dialog.get_node("WindowDialog/Label").text == dialog.dialog[len(dialog.dialog)-1]:
		two_menu.visible = false
		if PlayerData.player_data["Sprite"] == 0:
			$character.frame = 7
		elif PlayerData.player_data["Sprite"] ==1:
			$character.frame = 8 
		if decide == true:
			dialog.dialog = ["Let's begin with your name. What is it?"]
			$Menu_naming.visible = true
			popdialog.hide() 
		if confirmation == true:
			dialog.dialog = ["This is my grandson. He's been your rival since you were a baby.","...Erm, what is his name again?"]
			$Menu_naming.visible = true
		
var player_name_=null
func _on_Menu_naming_playername(value) -> void:
	player_name_ = value
	decide = false
	PlayerData.player_data["name"] = player_name_
	$Menu_naming.visible = false
	dialog.dialog = ["Is your name " + player_name_ + "?"]
	confirmation = true
	

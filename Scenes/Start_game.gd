extends Control
#MODIFY THE NEXT SCENE PATH VARIABLE TO MATCH THE GAME 
onready var boy = get_node("Box/boy")
onready var girl = get_node("Box/girl")
onready var verification = get_node("Box3/HBoxContainer/Label2")
onready var yes = get_node("Box3/yes")
onready var no = get_node("Box3/no")
export(String, FILE) var next_scene_path:= ""
onready var dialog = get_node("Dialog_box")
onready var two_menu = get_node("two_option_menu")
# Called when the node enters the scene tree for the first time.
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
		$Box.visible = true
		if decide == true:
			two_menu.visible = true
		if naming == true:
			name_player()
		if confirmation == true:
			two_menu.visible = true


func name_player():
	$Box2.visible = true
	
func _on_boy_pressed() -> void:
	if boy.pressed == true:
		girl.pressed = false
		PlayerData.player_data["Sprite"] = 0

func _on_girl_pressed() -> void:
	if girl.pressed == true:
		boy.pressed = false
		PlayerData.player_data["Sprite"] = 1

func _on_Next_pressed() -> void:
	if boy.pressed == false and girl.pressed == false:
		$Box/Choose.visible = true
	else:
		$Box.visible = false
		$Box2.visible = true
	
func _on_Name_text_entered(new_text: String) -> void:
	two_menu.get_node("menu/Yes").text = "Yes"
	two_menu.get_node("menu/No").text = "No"
	PlayerData.player_data["name"] = new_text
	$Box2.visible = false
	$Box3.visible = true
	verification.text = PlayerData.player_data["name"]
	dialog.dialog = ["IS YOUR NAME "]
	two_menu.visible = true
	naming=false
	confirmation=true
	
func _on_yes_pressed() -> void:
	if yes.pressed == true:
		no.pressed = false

func _on_no_pressed() -> void:
	if no.pressed == true:
		yes.pressed = false

func _on_confirmation_pressed() -> void:
	if yes.pressed == true:
		get_tree().change_scene(next_scene_path)
		print (PlayerData.player_data)
	if no.pressed == true:
		$Box3.visible = false
		_on_Next_pressed()
		
"""
func update_interface() -> void:
	PlayerData.player_data["name"]=pname
	PlayerData.player_data["Sprite"]=sprite
"""
var pressed = null
func _on_two_option_menu_is_pressed(value) -> void:
	pressed = value
	if pressed == 0 and naming==false and decide==true:
		PlayerData.player_data["Sprite"] = 0
	elif pressed == 1 and naming==false and decide==true:
		PlayerData.player_data["Sprite"] = 1
	if dialog.get_node("WindowDialog/Label").text == dialog.dialog[len(dialog.dialog)-1]:
		change_sprite()
		two_menu.visible = false
		dialog.dialog = ["Let's begin with your name. What is it?"]
		decide = false
		naming = true
		dialog.visible = false
	if pressed == 0 and naming == true and decide==false:
		dialog.visible = false
	elif pressed == 1 and naming == true and decide==false:
		$Box2.visible = true

func change_sprite():
	if pressed == 0:
		$character.frame = 7
	elif pressed == 1:
		$character.frame = 8

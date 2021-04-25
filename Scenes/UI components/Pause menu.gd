extends Control

onready var scene_tree := get_tree()
onready var pause_menu = get_node("pause_menu")
onready var pokedex = get_node("pause_menu/Pokedex")
onready var pokemon = get_node("pause_menu/Pokemon")
onready var bag = get_node("pause_menu/Bag")
onready var player = get_node("pause_menu/Player")
onready var save = get_node("pause_menu/Save")
onready var options = get_node("pause_menu/Options")
onready var exit = get_node("pause_menu/Exit")
signal is_paused(value)
var paused:= false setget set_paused
var directiony = [Vector2(816,48),Vector2(816,90.973),Vector2(816,136),Vector2(816,181.973),Vector2(816,225.973),Vector2(816,270.973),Vector2(816,314.973)]
var texts = ["Watch the pokemon you have seen and captured","See your pokemon stats","Look for things in your bag","See your pokemon trainer card","Save the current game","Modify the options of the game","Unpause the game or press P"]

func _ready() -> void:
	player.text = PlayerData.player_test["name"]
	self.paused = false
	$Label.text = texts[0]

func _process(delta: float) -> void:
	#$Label.text = texts[posy]
	if self.paused==true:
		set_process_unhandled_input(true)
	elif self.paused==false:
		set_process_unhandled_input(false)

func input_event_entered():
	if posy == 0:
		_on_Pokedex_pressed()
	elif posy == 1 or posy==-6:
		_on_Pokemon_pressed()
	elif posy == 2 or posy==-5:
		_on_Bag_pressed()
	elif posy == 3 or posy==-4:
		_on_Player_pressed()
	elif posy == 4 or posy==-3:
		_on_Save_pressed()
	elif posy == 5 or posy==-2:
		_on_Options_pressed()
	elif posy == 6 or posy==-1:
		_on_Exit_pressed()

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		self.paused = not paused
	
var posy = 0
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if $selector.rect_position == directiony[(posy)%len(directiony)]:
			$selector.rect_position = directiony[(posy-1)%len(directiony)]
		posy=(posy-1)%len(directiony)
		$Label.text = texts[posy]
	elif event.is_action_pressed("down"):
		if $selector.rect_position == directiony[(posy)%len(directiony)]:
			$selector.rect_position = directiony[(posy+1)%len(directiony)]
		posy=(posy+1)%len(directiony)
		$Label.text = texts[posy]
	if event.is_action_pressed("ui_accept"):
		input_event_entered()
	
func set_paused(value:bool)->void:
	paused=value
	pause_menu.visible=paused
	$TextureRect.visible = paused
	$dialoguebox.visible = paused
	$selector.visible = paused
	$Label.visible = paused
	emit_signal("is_paused",paused)
	#make it pause the characters movement
	
func _on_Exit_pressed() -> void:
	self.paused=false

func _on_Options_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/Options.tscn")

func _on_Save_pressed() -> void:
	$Label.text = "We're writing your game"
	PlayerData.save_game()

func _on_Player_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/Trainer_card.tscn")

func _on_Bag_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/Bag.tscn")

func _on_Pokemon_pressed() -> void:
	if len(PlayerData.player_test["Pokedex"])>=1:
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_box_keys.tscn")
	else:
		$Label.text = "You don't have any pokemon"
		
func _on_Pokedex_pressed() -> void:
	if PlayerData.got_pokedex==false:
		$Label.text = "You don't have a Pokedex"
	else:
		pass #MAKE A SCENE FOR THIS

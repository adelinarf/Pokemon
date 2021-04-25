extends Node2D


# Declare member variables here. Examples: 
# var b: String = "text"
onready var container = PlayerData.find_npc_dialogue()
onready var dialogue = container["Dialogue"]
onready var object = container["Object"]
onready var text_box = get_node("Label")
onready var menu = get_node("two_option_menu")
var first_time =true
var finished = false
export var part = 1
signal selected(value)
signal animate(value)
var selection = null setget set_selected
var animate = false setget set_animated
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.is_in[0]="beggining"
	PlayerData.colliding_character=String(part)
	if part==1:
		$two_option_menu/menu/Yes.text = "Boy"
		$two_option_menu/menu/No.text = "Girl"
	elif part==2:
		pass
	elif part==3:
		$two_option_menu/menu/Yes.text = "Blue"
		$two_option_menu/menu/No.text = "Bosco"
	#text_box.text = dialogue[0]
	visible = true
	#PlayerData.is_in[0] = "ViridianCity"
	#PlayerData.is_colliding_with = 1
	#PlayerData.colliding_character = "PC"
	menu.set_process_unhandled_input(false)
	print(container["Object"])
	#text_box.text = dialogue[0] #if i create the node everytime it collides


func set_selected(value):
	selection = value
	emit_signal("selected")
	
func set_animated(value):
	animate = value
	emit_signal("animate")
var rival = PlayerData.rival[0]["name"]
func update_dialogue():
	if part!=2:
		container = PlayerData.find_npc_dialogue()
		object = container["Object"]
		dialogue = container["Dialogue"]
		if part==3:
			print ("ENTRO AQUI")
			#if number ==3:
			#dialogue[2]= dialogue[2] + " " + rival+"!"
			#elif number ==3:
			#dialogue[3]=PlayerData.player_test["name"]+ "! " + dialogue[3]
	else:
		dialogue = ["Right! So your name is " + PlayerData.player_test["name"] + "?"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if first_time ==true:
		text_box.text = dialogue[0]
	if number!=0:
		first_time=false

var number = 0 #number=1 if i create the node everytime it collides
func _unhandled_input(event: InputEvent) -> void:
	update_dialogue()
	print ("IS ENTERING IN HANDLED INPUT FUNCTION")
	if event.is_action_pressed("ui_accept"):
		if number<len(dialogue):
			print (dialogue)
			if part!=2:
				text_box.text = dialogue[number]
			else:
				text_box.text = dialogue[number] + PlayerData.player_test["name"]+ " ?"
			if number==1 and part==1:
				self.animate = true
			elif number == 2 and part==1:
				print ("HEREHER")
				menu.visible=true
				menu.set_process_unhandled_input(true)
			elif number == len(dialogue)-1 and part==2:
				menu.visible=true
				menu.set_process_unhandled_input(true)
			elif number == 1 and part==3:
				menu.visible=true
				menu.set_process_unhandled_input(true)
			number+=1
			print (number)
		else:
			if selected==true:
				handle_action()
				finished =true
			else:
				number=0
			#visible = false
			#queue_free()
			#hide()
		
func handle_options():
	menu.visible = true
	menu.set_process_unhandled_input(true)
	#menu.visible = true

func handle_action():
	if part==1:
		get_tree().change_scene("res://Scenes/UI components/Menu_naming.tscn")
	elif part==2:
		if self.selection==1:
			get_tree().change_scene("res://Scenes/UI components/Menu_naming.tscn")
		elif self.selection==0:
			get_tree().change_scene("res://Scenes/Start_game3.tscn")
	elif part==3:
		get_tree().change_scene("res://Scenes/World/Pallet Town.tscn")

func yes():
	if part==1:
		self.selection=0
	elif part==2:
		self.selection==0
		get_tree().change_scene("res://Scenes/Start_game3.tscn")
	elif part==3:
		rival = "Blue"
		set_rival_name(rival)
		menu.visible=false
		
func no():
	if part==1:
		self.selection=1
	elif part==2:
		self.selection=1
		get_tree().change_scene("res://Scenes/UI components/Menu_naming.tscn")
	elif part==3:
		rival = "Bosco"
		set_rival_name(rival)
		menu.visible=false
var selected=false
func _on_two_option_menu_is_pressed(value) -> void:
	selected=true
	if value == 0:
		yes()
	elif value == 1:
		no()
	if part==1:
		PlayerData.player_test["Sprite"]=value
	menu.set_process_unhandled_input(false)
	#menu.visible = false

func set_rival_name(rival):
	var dialogue_begg = PlayerData.dialogue.beggining
	var pos = null
	for x in range(len(dialogue_begg)):
		if dialogue_begg[x]["name"]=="3":
			pos = x
	dialogue_begg[pos]["Dialogue"][2]+= " "+ rival +"!"
	dialogue_begg[pos]["Dialogue"][3]= PlayerData.player_test["name"]+ "! " + dialogue_begg[pos]["Dialogue"][3]
	ResourceSaver.save("res://dialogues/dialogues.tres", PlayerData.dialogue)
	PlayerData.rival[0]["name"]=rival
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.pallet_town)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route1)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.viridian_city)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route2)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.pewter_city)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route3)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.mt_moon)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route4)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.cerulean_city)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route24)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route25)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route5)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route6)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.vermilion_city)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route9)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route10)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.lavender_town)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route8)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.celadon_city)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route11)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.route7)
	PlayerData.set_every_dialogue_name(PlayerData.dialogue.saffron_city)

extends Node2D


# Declare member variables here. Examples: 
# var b: String = "text"
onready var container = PlayerData.find_npc_dialogue()
onready var dialogue = container["Dialogue"]
onready var object = container["Object"]
onready var text_box = get_node("Label")
onready var menu = get_node("two_option_menu")
onready var menu2 = get_node("three_option_menu")
var first_time =true
var finished = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#text_box.text = dialogue[0]
	visible = true
	#PlayerData.is_in[0] = "ViridianCity"
	#PlayerData.is_colliding_with = 1
	#PlayerData.colliding_character = "PC"
	menu.set_process_unhandled_input(false)
	menu2.set_process_unhandled_input(false)
	#text_box.text = dialogue[0] #if i create the node everytime it collides

func update_dialogue(options):
	container = PlayerData.find_npc_dialogue()
	object = container["Object"]
	if options == false:
		dialogue = container["Dialogue"]
	elif options == true:
		if PlayerData.is_colliding_with == 0:
			dialogue = container["Dialogue"].slice(0, len(container)-1,1)
		elif PlayerData.is_colliding_with == 3:
			if container["Already_talk"]==false:
				dialogue = container["Dialogue"].slice(0, len(container)-3,1)
			elif container["Already_talk"]==true:
				dialogue = [container["Dialogue"][len(container["Dialogue"])-1]]
		elif PlayerData.is_colliding_with==6:
			dialogue = container["Dialogue"].slice(0, len(container)-3,1)
		else:
			dialogue = container["Dialogue"].slice(0, len(container)-1,1)
	if PlayerData.is_colliding_with==1:
		var pokemon = len(PlayerData.player_test["Pokedex"])
		var number_seen_pokemon = 10
		var string = "You have captured " + String(pokemon) + " pokemon "+ "and have seen " + String(number_seen_pokemon) + " pokemon"
		var more_text = ""
		if pokemon < 50:
			more_text = "\n You need to keep capturing pokemon"
		elif 50 < pokemon < 100:
			more_text = "\n Keep on capturing pokemon"
		else:
			more_text = "\n You're a great trainer, keep capturing pokemon"
		dialogue[len(dialogue)-1]=string+"\n"+more_text
	elif PlayerData.is_colliding_with==6 and container["name"]=="Anne 2" and PlayerData.is_in[0]=="VermilionCity":
		var is_ = false
		for x in range(len(PlayerData.player_test["Bag"][1]["Content"])):
			if PlayerData.player_test["Bag"][1]["Content"][x][0]=="Ticket":
				is_ = true
			else:
				is_ = false
		if is_==true:
			pass
		elif is_==false:
			container["Dialogue"][len(container["Dialogue"])-1]="Don't be a liar"
	else:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if first_time ==true:
		text_box.text = dialogue[0]
	if number!=0:
		first_time=false

var pressed =false
var number = 0 #number=1 if i create the node everytime it collides
func _unhandled_input(event: InputEvent) -> void:
	update_dialogue(pressed)
	if event.is_action_pressed("ui_accept"):
		if number<len(dialogue):
			text_box.text = dialogue[number]
			if number == len(dialogue)-3 and PlayerData.is_colliding_with!=0 and PlayerData.is_colliding_with!=5 and PlayerData.is_colliding_with!=1:
				handle_options(PlayerData.is_colliding_with)
			elif number == len(dialogue)-4 and PlayerData.is_colliding_with ==0:
				handle_options(PlayerData.is_colliding_with)
			elif number == len(dialogue)-2 and PlayerData.is_colliding_with ==5:
				handle_options(PlayerData.is_colliding_with)
			elif number == len(dialogue)-2 and PlayerData.is_colliding_with==1:
				handle_options(PlayerData.is_colliding_with)
			number+=1
		else:
			handle_action(PlayerData.is_colliding_with)
			finished =true
			visible = false
			#queue_free()
			#hide()
		
func handle_options(colliding):
	#menu.set_process_unhandled_input(true)
	if colliding == 0 or colliding ==3 or colliding ==5 or colliding==6:
		menu.set_process_unhandled_input(true)
		menu.visible = true
	elif colliding ==1:
		menu2.set_process_unhandled_input(true)
		menu2.visible = true
	else:
		menu.visible=false
		menu.set_process_unhandled_input(false)

func handle_action(colliding):
	if colliding == 2:
		if PlayerData.colliding_character=="After_getting_pokemon":
			PlayerData.current_trainer = PlayerData.find_rival_pokemon()
			#PlayerData.current_trainer = PlayerData.rival[0]
		elif PlayerData.colliding_character=="Rival_Fight":
			PlayerData.current_trainer = PlayerData.find_rival_pokemon()
		else:
			PlayerData.current_trainer = PlayerData.find_trainer(container["name"],PlayerData.is_in[0])
		get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")
	else:
		pass

func yes(colliding):
	if colliding == 0:
		 #text_box.text = "We're healing your pokemon"
		PlayerData.heal_pokemon()
		number=number+1
	elif colliding == 1:
		pass # give options to pc
	elif colliding == 2:
		pass # pass
	elif colliding == 3:
		number=number+1
		container["Already_talk"]=true
		ResourceSaver.save("res://dialogues/dialogues.tres", PlayerData.dialogue)
		var num = container["Object"][0]
		var item = container["Object"][1]
		var quantity = container["Object"][2]
		PlayerData.player_test["Bag"][num]["Content"].append([item,quantity])
		#Add object to bag THERE'S NO CODE FOR THIS
	elif colliding == 4:
		pass #pass
	elif colliding ==5:
		get_tree().change_scene("res://Scenes/UI components/Mall.tscn")
		pass #optiones to say yes or no and set the mall thing
	elif colliding==6:
		number=number+1
		if container["name"]=="Museum 1 Scientist1" and PlayerData.is_in[0]=="PewterCity":
			PlayerData.player_test["Money"]-=50
		else: 
			pass
	
func no(colliding):
	#update_dialogue(true)
	if colliding == 0:
		pass #number=len(dialogue)
	elif colliding == 1:
		pass # give options to pc
	elif colliding == 2:
		pass # pass
	elif colliding == 3:
		pass #number+=1
	elif colliding == 4:
		pass #pass
	elif colliding ==5:
		pass
	elif colliding==6:
		pass

func _on_two_option_menu_is_pressed(value) -> void:
	$Label2.text = String(value)
	if value == 0:
		yes(PlayerData.is_colliding_with)
	elif value == 1:
		pressed = true
		no(PlayerData.is_colliding_with)
	menu.set_process_unhandled_input(false)
	menu.visible = false

func oak():
	#var pokemon = len(PlayerData.player_test["Pokedex"])
	#var number_seen_pokemon = 10
	#dialog_text.text = "You have captured " + String(pokemon) + " pokemon "+ "\n and have seen " + String(number_seen_pokemon) + " pokemon"
	#var more_text = ""
	#if pokemon < 50:
	#	more_text = "\n You need to keep \n capturing pokemon"
	#elif 50 < pokemon < 100:
	#	more_text = "\n Keep on capturing pokemon"
	#else:
	#	more_text = "\n You're a great trainer, \n keep capturing pokemon"
	#dialog_text.text += more_text
	#dialog_number = 0
	pass
func _on_three_option_menu_is_pressed(value) -> void:
	if value == 0:
		get_tree().change_scene("res://Scenes/UI components/PlayerPC.tscn")
	elif value == 1:
		get_tree().change_scene("res://Scenes/UI components/BillPC.tscn")
	elif value == 2:
		oak()
	menu2.set_process_unhandled_input(false)
	menu2.visible = false
		

extends Control

var enemy_attacks = PlayerData.enemy_pokemon_info
var player_attacks = PlayerData.get_player_attacks()
var name_pokemon_player = player_attacks[0]
var info_player_id = player_attacks[1][0]
var info_player_type = player_attacks[1][1]
var info_player_base = player_attacks[1][2]
var info_player_position = player_attacks[3]
var move_player = player_attacks[2]
onready var enemy_s = get_node("enemy")
onready var player_s = get_node("player")
var battle_info = PlayerData.battle_finished
var dialogue = ["The battle is over","","",""]
onready var text_box = get_node("text")
var first=true
# Called when the node enters the scene tree for the first time.

func _ready():
	$two_option_menu.set_process_unhandled_input(false)
	print (battle_info)
	set_process_unhandled_input(true)
	PlayerData.set_pokemon_sprite(enemy_s,enemy_attacks[0]["id"],false)
	PlayerData.set_pokemon_sprite(player_s,info_player_id,true)
	
func _process(delta):
	if first ==true:
		text_box.text = dialogue[0]
	if number!=0:
		first=false
	
func update_dialogue():
	if PlayerData.is_colliding_with==2:
		if battle_info[0]=="won":
			dialogue = [PlayerData.current_trainer["Dialogue"][1],"You have won "+ String(battle_info[1]) + " $"]
		elif battle_info[0]=="lost":
			dialogue = [PlayerData.current_trainer["Dialogue"][0],"You have lost "+ String(battle_info[1])+ " $"] 
	else:
		if battle_info[0]=="won":
			dialogue = ["The pokemon have run away"]
		elif battle_info[0]=="lost":
			dialogue = ["You have lost terribly"]
		elif battle_info[0]=="catched":
			dialogue = ["Do you wanna nickname your pokemon?"]
		elif battle_info[0]=="escaped":
			dialogue = ["The savage pokemon has escaped"]

var number=0
func _unhandled_input(event: InputEvent) -> void:
	update_dialogue()
	if event.is_action_pressed("ui_accept"):
		print ("HEREHRE",number,dialogue)
		if number<len(dialogue):
			text_box.text = dialogue[number]
			number+=1
		else:
			if PlayerData.is_colliding_with!=2:
				if battle_info[0]=="catched":
					$two_option_menu.visible = true
					$two_option_menu.set_process_unhandled_input(true)
				elif battle_info[0]=="won":
					get_tree().change_scene(PlayerData.is_in[1])
				elif battle_info[0]=="lost":
					all_pokemon_fainted()
				elif battle_info[0]=="escaped":
					get_tree().change_scene(PlayerData.is_in[1])
			elif PlayerData.is_colliding_with==2:
				if battle_info[0]=="won":
					win_money()
					won_medal()
					set_talked()
					get_tree().change_scene(PlayerData.is_in[1])
				elif battle_info[0]=="lost":
					lost_money()
					all_pokemon_fainted()
					#get_tree().change_scene(PlayerData.is_in[1])

func set_talked():
	if PlayerData.current_trainer["Class"]=="Gym Leader" or (PlayerData.current_trainer["Name_dialogue"]=="Giovanni" and PlayerData.is_in[0]=="SaffronCity"):
		var arr = PlayerData.current_dialogue
		var dia = PlayerData.dialogue
		var pos = null
		for x in range(len(arr)):
			if arr[x]["name"]==PlayerData.current_trainer["Name_dialogue"]:
				pos = x
		arr[pos]["Already_talk"]=true
		ResourceSaver.save("res://dialogues/dialogues.tres", dia)


func win_money():
	PlayerData.player_test["Money"]+=int(battle_info[1])

func won_medal():
	if PlayerData.current_trainer["Class"]=="Gym Leader":
		if PlayerData.is_in[0]=="ViridianCity":
			pass
		elif PlayerData.is_in[0]=="PewterCity":
			PlayerData.player_test["Medals"]["BOULDERBADGE"]=true
		elif PlayerData.is_in[0]=="CeruleanCity":
			PlayerData.player_test["Medals"]["CASCADEBADGE"]=true
		elif PlayerData.is_in[0]=="VermilionCity":
			PlayerData.player_test["Medals"]["THUNDERBADGE"]=true
	else:
		pass



func lost_money():
	PlayerData.player_test["Money"]-=int(battle_info[1])
	
func all_pokemon_fainted():
	set_process_unhandled_input(false)
	$ColorRect/AnimationPlayer.current_animation = "fade out"
	$ColorRect.visible=true
	$ColorRect/AnimationPlayer.play("fade out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade out":
		$Label.visible = true
		$Timer.set_wait_time(5)
		$Timer.start()
		#get_tree().change_scene(PlayerData.is_in[1])


func _on_Timer_timeout():
	print ("TIMER DONE") #SEND TO POKEMON CENTER TO HEAL
	get_tree().change_scene(PlayerData.is_in[1])

func _on_two_option_menu_is_pressed(value):
	print (value, "from the menu of deciding name")
	if PlayerData.is_colliding_with!=2 and battle_info[0]=="catched":
		if value==0:
			get_tree().change_scene("res://Scenes/UI components/Menu_name_pokemon.tscn")
		elif value==1:
			var experience = (int(floor(4*pow(enemy_attacks[2],3) / 5)))
			PlayerData.newpokemon(enemy_attacks[0]["name"]["english"], enemy_attacks[2], PlayerData.enemy_pokemon_info[0]["base"]["HP"], enemy_attacks[1], experience,"")
			get_tree().change_scene(PlayerData.is_in[1])
#PlayerData.newpokemon(enemy_pokemon["name"]["english"], enemy_attacks[2], PlayerData.enemy_pokemon_info[0]["base"]["HP"], enemy_attacks[1], calculate_experience_points_enemy(enemy_attacks[2]),nickname)


func _on_Battle_beggining_tree_exiting():
	PlayerData.player_test["Fighting"]=false

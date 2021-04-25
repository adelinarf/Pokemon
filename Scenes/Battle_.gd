extends Control
var path = "res://pokedex.json"
var path_movement = "res://moves.json"
var STATES = {
	"PLAYER":false,    # Player's turn
	"ENEMY":false,    # Enemy's turn
	"WIN":false,    # If player wins
	"LOSE":false,    # If enemy wins
	"RUN":false    # If they RUN from the battle
}
var current_state = null
onready var progressbar_player = get_node("Progress bar player")
onready var progressbar_enemy = get_node("Progress bar enemy")

var enemy_attacks = PlayerData.enemy_pokemon_info
var player_attacks = PlayerData.get_player_attacks()
var name_pokemon_player = player_attacks[0]
var info_player_id = player_attacks[1][0]
var info_player_type = player_attacks[1][1]
var info_player_base = player_attacks[1][2]
var info_player_position = player_attacks[3]
var move_player = player_attacks[2]
onready var enemy_s = get_node("enemy_sprite")
onready var player_s = get_node("player_sprite")

var nickname = ""
var nickname_changed = false
func _ready() -> void:
	$menu_movements.visible = false
	$menu.visible=true
	$someoneplays.text = String(enemy_attacks)
	PlayerData.set_pokemon_sprite(enemy_s,PlayerData.enemy_pokemon_info[0]["id"],false)
	PlayerData.set_pokemon_sprite(player_s,info_player_id,true)
	randomize()
	$enemymove.text = "What will " + name_pokemon_player + " do?"
	PlayerData.pokemon_participate_in_battle.append(info_player_position)
	var data = PlayerData.parse_json_files(path)
	var player_pokemon = PlayerData.player_test["Pokedex"][info_player_position]
	var enemy_pokemon = enemy_attacks[0]
	$enemy_level.text = String(enemy_attacks[2])
	$enemy_name.text = enemy_pokemon["name"]["english"]
	var max_hp_enemy = PlayerData.get_pokemon_info_by_name(enemy_pokemon["name"]["english"])
	var max_hp_player = PlayerData.get_pokemon_info_by_name(player_pokemon["name"])
	progressbar_enemy.get_node("TextureProgress").max_value = max_hp_enemy[2]["HP"]
	progressbar_player.get_node("TextureProgress").max_value = max_hp_player[2]["HP"]
	progressbar_enemy.get_node("TextureProgress").value = PlayerData.enemy_pokemon_info[0]["base"]["HP"]
	progressbar_player.get_node("TextureProgress").value = player_pokemon["HP"]
	$player_level.text = String(player_pokemon["Level"])
	$player_name.text = player_pokemon["name"]
	STATES.PLAYER=true
	#_handle_state_()
	if PlayerData.catching_pokemon == true and PlayerData.is_colliding_with!=2:
		if PlayerData.enemy_pokemon_info[0]["base"]["HP"] < 50:
			$new_pokemon_name.visible = true
			#if nickname_changed == true:
				#PlayerData.newpokemon(enemy_pokemon["name"]["english"], enemy_attacks[2], PlayerData.enemy_pokemon_info[0]["base"]["HP"], enemy_attacks[1], calculate_experience_points_enemy(enemy_attacks[2]),nickname)
			$Label.text = "You have caught the savage pokemon"
			PlayerData.catching_pokemon = false
			STATES.WIN = true 
			end_battle("catched",0,0,false)
		else:
			end_battle("escaped",0,0,false)
	elif PlayerData.catching_pokemon == true and PlayerData.is_colliding_with==2:
		$enemymove.text = "You can't STOLE another trainer pokemon"
		#get_tree().change_scene("res://Scenes/Battle_ending.tscn")

func new_pokemon_nickname():
	$new_pokemon_name.visible = true

func _on_LineEdit_text_entered(new_text: String) -> void:
	nickname = new_text
	nickname_changed = true


func _handle_state_():
	var someone = get_node("someoneplays")
	if progressbar_enemy.get_node("TextureProgress").value == 0:
		print ("YOU HAVE WON")
		STATES.WIN = true
		if PlayerData.is_colliding_with == 2:
			if PlayerData.current_trainer["Is_fighting"] + 1 < len(PlayerData.current_trainer["Pokemon"]):
				PlayerData.current_trainer["Is_fighting"] += 1
				get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")
			else:
				end_fight("won")
		else:
			end_fight("won")
	elif progressbar_player.get_node("TextureProgress").value == 0:
		STATES.LOSE = true
		print ("YOU HAVE LOST")
		if PlayerData.is_colliding_with == 2:
			end_fight("lost")
		else:
			end_fight("lost")
	elif STATES.PLAYER == true:
		someone.text = "It's your turn"
		$menu.visible = true
		$menu_movements.visible=false
		_on_Fight_pressed()
	elif STATES.ENEMY == true:
		someone.text = "It's the savage pokemon turn"
		$menu.visible = false
		$menu_movements.visible = false
		enemy_attacks()

func end_fight(state):
	var states = get_node("winlose")
	states.visible = true
	PlayerData.player_test["Pokedex"][info_player_position]["HP"] = progressbar_player.get_node("TextureProgress").value
	var money=0
	var levelup=false
	if state == "lost":
		var pokemon_ = get_able_to_fight_pokemon_position()
		var x = PlayerData.fighting_pokemon
		#get_tree().change_scene("res://Scenes/Battle_.tscn")
		#ates.text=String(x)+"  yaya"
		if PlayerData.player_test["Pokedex"][info_player_position]["HP"] == 0:
			states.text="SI ESTA ENTRANDO"
			if (x+1) < len(pokemon_):
				PlayerData.fighting_pokemon = PlayerData.player_test["Pokedex"][pokemon_[x+1]]["Order_in_fight"]
				states.text="LET THE NEXT ONE COME IN"
				get_tree().change_scene("res://Scenes/Battle_.tscn") #cambiar por get scene for real
			else:
				states.text="YOU HAVE TRULY LOST"
		states.text=String(x)+"  yaya"
	 # si quedan mas pokemn seguir la pelea
	elif state == "won":
		var expe = experience()
		var experience_for_every_pokemon = expe/len(PlayerData.pokemon_participate_in_battle)
		for x in range(len(PlayerData.pokemon_participate_in_battle)):
			for i in range(len(PlayerData.player_test["Pokedex"])):
				if i == PlayerData.pokemon_participate_in_battle[x]:
					PlayerData.player_test["Pokedex"][i]["Experience"] += experience_for_every_pokemon
		levelup=level_up(PlayerData.player_test["Pokedex"][info_player_position]["Level"])
		if PlayerData.is_colliding_with == 2:
			states.text="YOU HAVE WON THIS MONEY "+ money_won()
			money = money_won()
		else:
			states.text="YOU HAVE WON"
	end_battle(state,money,experience()/len(PlayerData.pokemon_participate_in_battle),levelup)
	#get_tree().change_scene("res://Scenes/Change_scene_button.tscn")
	$Label.text = String(PlayerData.player_test["Pokedex"][0]["Experience"])
	#$Label2.text = String(PlayerData.player_test["Pokedex"][1]["Experience"]) 

func end_battle(state,money,experience,levelup):
	$someoneplays.text = "IS ENTERING THE FUNCTION"
	PlayerData.battle_finished[0]=state
	PlayerData.battle_finished[1]=money
	PlayerData.battle_finished[2]=experience
	PlayerData.battle_finished[3]=levelup
	$Timer.set_wait_time(2)
	$Timer.start()
	
	
func money_won()->String:
	var classes = PlayerData.current_trainer["Class"]
	var enemy_level = enemy_attacks[2]
	var data = PlayerData.parse_json_files("res://pokemon_trainer_class.json")
	var money = enemy_level * data[0][classes]
	return (String(money))
	
func level_up(level:int)->bool:
	var target_value = calculate_experience_points_enemy(level+1)
	var current_value = PlayerData.player_test["Pokedex"][info_player_position]["Experience"]
	if current_value >= target_value:
		PlayerData.player_test["Pokedex"][info_player_position]["Level"] += 1
		return true
	else:
		return false
	
func get_able_to_fight_pokemon_position()-> Array:
	var pokemon = [null,null,null,null]
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 0:
			pokemon[0]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 1:
			pokemon[1]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 2:
			pokemon[2]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == 3:
			pokemon[3]=x
		elif PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			pass
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x=x+1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
	var output = pokemon.slice(0,maximum)
	return (output)
	
func experience() -> int:
	var enemy_level = enemy_attacks[2]
	var enemy_experience = calculate_experience_points_enemy(enemy_level)
	var type_fight = 1  # IF its with a trainer is 1.5
	#var experience_points = (enemy_experience * enemy_level * type_fight)/ 7
	#THE COMMENTARY BEFORE WAS THE FUNCTION SUPPOSED TO BE HERE
	# BUT THE NUMBERS ARE TOO BIG AND I DONT LIKE IT
	var experience_points = (enemy_experience + enemy_level * type_fight)/ 7
	return (experience_points)

func calculate_experience_points_enemy(level:int)->int:
	var output = (int(floor(4*pow(level,3) / 5)))
	return (output)
	
func enemy_attacks()-> bool:
	var attacks = enemy_attacks[1]
	var number = randi() % len(attacks)
	var damage2 = 5 #damage_to_player(number)
	#var damage2 = enemy_attacks[1][number]["power"]
	#if damage2 == null:
	#	damage2 = 0
	if STATES.PLAYER == false:
		progressbar_player.get_node("TextureProgress").value = progressbar_player.get_node("TextureProgress").value - (damage2)
		PlayerData.player_test["Pokedex"][info_player_position]["HP"] = PlayerData.player_test["Pokedex"][info_player_position]["HP"] - (damage2)
		STATES.PLAYER = true
		STATES.ENEMY = false
		$Timer.set_wait_time(2)
		$Timer.start()
		$menu.is_enemy=true
		#PUT ANIMATIONS HERE
		
		$enemymove.visible = true
		$enemymove.text = "%s" % enemy_attacks[0]["name"]["english"] + " has used %s " % enemy_attacks[1][number]["ename"] #WHICH MOVE IS USING THE ENEMY
		_handle_state_()
		return true
	else:
		return false

func manage_time():
	#set_process_input(false)
	$menu_movements.visible=false
	
	#proceso()
	
	#set_process_input(false)
	$Label2.text="ENEMY POKEMON TIME"
	
var selected_attack = 0
var selected = false
	
func damage(level,power,A,D,target,weather,random,type,STAB)->float:
	var modifier = target*weather*type*STAB
	if power == null:
		power = 1
	else:
		pass
	var damage = ((2*level/5*2)*power*(A/D)/5)+2*modifier
	return (damage)
	
func damage_to_player(number) -> float:
	var level = enemy_attacks[2]
	var power = enemy_attacks[1][number]["power"] 
	var info = PlayerData.get_pokemon_info_by_name(enemy_attacks[0]["name"]["english"])
	var A = enemy_attacks[0]["base"]["Attack"]
	var D = info_player_base["Defense"]
	var target = 0.75
	var weather = 1.5
	var random = 1
	var type = null
	var STAB = null
	for x in range(len(info[1])):
		if info[1][x] == enemy_attacks[1][number]["type"]:
			STAB = 1.5
			type = 1
		else:
			STAB = 1
			type = 2
	var out = (int(floor(damage(level,power,A,D,target,weather,random,type,STAB))))
	return (out)
	
func damage_to_enemy() -> float:
	var level = PlayerData.player_test["Pokedex"][info_player_position]["Level"]
	var power = move_player[selected_attack]["power"]
	var info = PlayerData.get_pokemon_info_by_name(PlayerData.player_test["Pokedex"][info_player_position]["name"])
	var A = info_player_base["Attack"]
	var D = enemy_attacks[0]["base"]["Defense"]
	var target = 0.75
	var weather = 1.5
	var random = 1
	var type = null
	var STAB = null
	for x in range(len(PlayerData.enemy_pokemon_info[0]["type"])):
		if PlayerData.enemy_pokemon_info[0]["type"][x] == move_player[selected_attack]["type"]:
			STAB = 1.5
			type = 1
		else:
			STAB = 1
			type = 2
	var out = (int(floor(damage(level,power,A,D,target,weather,random,type,STAB))))
	return (out)

	
func _on_Fight_pressed() -> bool:
	#var damage = move_player[selected_attack]["power"]
	#if damage == null:
		#damage = 0
	var damage = 10 #damage_to_enemy()
	print (damage)
	if selected == true and STATES.PLAYER == true:
		$Timer.stop()
		progressbar_enemy.get_node("TextureProgress").value = progressbar_enemy.get_node("TextureProgress").value - (damage)
		PlayerData.enemy_pokemon_info[0]["base"]["HP"] = PlayerData.enemy_pokemon_info[0]["base"]["HP"] - (damage)
		PlayerData.player_test["Pokedex"][info_player_position]["Movements"][selected_attack]["pp"]-=1
		STATES.PLAYER = false
		STATES.ENEMY = true
		#manage_time()
		selected = false
		_handle_state_()
		return true
	else:
		return false

func _on_Pokemon_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/Pokemon_info_box_keys.tscn")

func _on_Bag_pressed() -> void:
	get_tree().change_scene("res://Scenes/UI components/Bag.tscn")

func _on_Run_pressed() -> void:
	#change scene to another and go on with the game
	pass # Replace with function body.
var selected_item = ""

func _process(delta):
	$enemymove.visible = not $menu_movements.visible
	print($menu_movements.visible,"this is movements")
	print($menu.visible,"this is regular menu")

func proceso1():
	if not $menu_movements.visible:
		pass
func proceso():
	pass
	
	

func _on_menu_selected_by_key(value) -> void:
	selected_item = value
	if selected_item == "Fight":
		$menu_movements.visible = true
		$menu.visible=false
		#proceso()
	elif selected_item == "Pokemon":
		get_tree().change_scene("res://Scenes/UI components/Pokemon_info_box_keys.tscn")
	elif selected_item == "Bag":
		get_tree().change_scene("res://Scenes/UI components/Bag.tscn")
	elif selected_item == "Run":
		pass
		
	if len(move_player) == 1:
		$menu_movements/move1.text = (move_player[0]["ename"])
		$menu_movements/move2.visible = false
		$menu_movements/move3.visible = false
		$menu_movements/move4.visible = false
	elif len(move_player) == 2:
		$menu_movements/move1.text = (move_player[0]["ename"])
		$menu_movements/move2.text = (move_player[1]["ename"])
		$menu_movements/move3.visible = false
		$menu_movements/move4.visible = false
	elif len(move_player) == 3:
		$menu_movements/move1.text = (move_player[0]["ename"])
		$menu_movements/move2.text = (move_player[1]["ename"])
		$menu_movements/move3.text = (move_player[2]["ename"])
		$menu_movements/move4.visible = false
	else:
		$menu_movements/move1.text = (move_player[0]["ename"])
		$menu_movements/move2.text = (move_player[1]["ename"])
		$menu_movements/move3.text = (move_player[2]["ename"])
		$menu_movements/move4.text = (move_player[3]["ename"])

	
func _on_menu_movements_selected_by_key(value) -> void:
	print (value," selectedmove")
	if value==null:
		print ("EL MOVIMIENTO DA NULL")
	else:
		print (value,"selectedmove")
		selected_attack = value
		selected = true
		_handle_state_()

func _on_menu_movements_show_move(value) -> void:
	var selected_ = value
	var position = 0
	for x in range(len(move_player)):
		if selected_ == move_player[x]["ename"]:
			position = x
	$menu_movements/Control/current_pp.text = String(move_player[position]["pp"])
	$menu_movements/Control/pptotal.text = String(PlayerData.get_max_movement_pp(move_player[position]))
	$menu_movements/Control/type.text = move_player[position]["type"]
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and $menu_movements.visible == true:
		$menu_movements.visible = false
		$menu.visible = true
	if event.is_action_pressed("ui_accept") and selected_attack!=null and selected == true and STATES.PLAYER == true:
		pass #_on_Fight_pressed()  #NECESITA UNA CONDICION DE MAS PARA QUE NO SE PUEDA DAR CLICK CUANDO ES EL TURNO DEL ENEMIGO
	if event.is_action_pressed("ui_accept") and selected_attack!=null and selected!=true and STATES.PLAYER!=true:
		pass

func _on_Timer_timeout():
	if STATES.WIN ==true or STATES.LOSE==true:
		$Timer.stop()
		$enemymove.text = "TIMER DONE"
		get_tree().change_scene("res://Scenes/Battle_ending.tscn")
	else:
		$menu.is_enemy=false
		$menu.visible=true
		$someoneplays.text="ENEMY ENDED"
		$enemymove.text = "What will " + name_pokemon_player + " do?"
		$Timer.stop()

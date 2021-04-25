extends Control

onready var read_text = get_node("text")
onready var timer = get_node("Timer")
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	PlayerData.player_test["Fighting"]=true
	set_process_unhandled_input(false)
	if PlayerData.is_colliding_with == 2:
		if PlayerData.current_trainer["Is_fighting"] == 0:
			var new_pokemon = PlayerData.new_battle_trainer()
			read_text.text = PlayerData.current_trainer["name"] + "wants to fight with you"
			PlayerData.enemy_pokemon_info = new_pokemon
		else:
			var new_pokemon = PlayerData.new_battle_trainer()
			read_text.text = PlayerData.current_trainer["name"] + "next pokemon is " + new_pokemon[0]["name"]["english"]
			PlayerData.enemy_pokemon_info = new_pokemon
	else:
		var new_pokemon = PlayerData.new_battle()
		read_text.text = "You have found a savage " + new_pokemon[0]["name"]["english"] + " Level " + String(new_pokemon[2])
		PlayerData.enemy_pokemon_info = new_pokemon
	#print (PlayerData.enemy_pokemon_info[0]["base"]["HP"])
	select_sprite_to_show()

func select_sprite_to_show():
	if PlayerData.player_test["Sprite"] == 0:
		$AnimatedSprite.animation = "boy_throwing_pokeball"
	elif PlayerData.player_test["Sprite"] == 1:
		$AnimatedSprite.animation = "girl_throwing_pokeball"
	#SELECT POKEMON SPRITE TO SHOW TOO
	var enemy = $enemy
	PlayerData.set_pokemon_sprite(enemy,PlayerData.enemy_pokemon_info[0]["id"],false)
	enemy.get_node("AnimationPlayer").current_animation = "Move_enemy_pokemon"
	timer.set_wait_time(5) 
	timer.start()
	

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://Scenes/Battle_.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if PlayerData.is_colliding_with==2:
			var arr = PlayerData.current_dialogue
			var dia = PlayerData.dialogue
			var pos = null
			for x in range(len(arr)):
				if arr[x]["name"]==PlayerData.current_trainer["Name_dialogue"]:
					pos = x
			if PlayerData.current_trainer["Name_dialogue"]=="Rival" or PlayerData.current_trainer["Name_dialogue"]=="Rival_Anne" or PlayerData.current_trainer["Name_dialogue"]=="After_getting_pokemon":
				var pos_r=null
				for x in range(len(arr)):
					if arr[x]["name"]=="Rival_Fight":
						pos_r = x
					elif arr[x]["name"]=="After_getting_pokemon":
						pos_r = x
				arr[pos_r]["Already_talk"]=true
			elif PlayerData.current_trainer["Class"]=="Gym Leader":
				pass
			elif PlayerData.current_trainer["Name_dialogue"]=="Giovanni" and PlayerData.is_in[0]=="SaffronCity":
				pass
			else:
				arr[pos]["Already_talk"]=true
			if PlayerData.current_trainer["Name_dialogue"] == "Trainer 1" and PlayerData.is_in[0]=="CeruleanCity":
				arr[pos-1]["Dialogue"]=arr[pos+2]["Dialogue"]
			ResourceSaver.save("res://dialogues/dialogues.tres", dia)
		get_tree().change_scene("res://Scenes/Battle_.tscn")
	
func _on_Timer_timeout() -> void:
	$AnimatedSprite.playing = true

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Move_enemy_pokemon":
		print ("YOU CAN USE KEYS")
		set_process_unhandled_input(true)

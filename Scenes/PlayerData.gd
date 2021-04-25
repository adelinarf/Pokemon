extends Node

signal player_data_updated
#var resource = load("res://player_info.tres")
var pokemon_selected = 0
var player_data = {} setget set_data
var player_test = {"name": "ADE",
			"Sprite":1,
			"id":0,
			"Money":100,
			"Fighting":false,
			"Pokedex" : [{ "name": "Bulbasaur",
							"Level" : 16,
							"HP" : 40, 
							"Habitat":"Grassland",
							"Nickname": "Blob",
							"Id number":1596863463,
							"Movements" : [{
											"accuracy": 100, 
											"category": "\u7269\u7406", 
											"cname": "\u85e4\u97ad", 
											"ename": "Vine Whip", 
											"id": 22, 
											"jname": "\u3064\u308b\u306e\u30e0\u30c1", 
											"power": 45, 
											"pp": 23,  #25
											"type": "Grass"}
										],
							"In_PC": null,
							"Order_in_fight":0,
							"Objects":null,
							"Experience": 13
						  }],
			"Bag":  [{ "name": "Pokeballs",
							"Content" : [["Pokeball",7]]
						  }, { "name":"Key Items",
							"Content" : [] }, #["Ticket",1]
						{ "name":"Items",
						   "Content":[["CUT",1]] } #["CUT",1]
				],
			"PC_Objects" : [{ "name": "Pokeballs",
							"Content" : []
						  }, { "name":"Key Items",
							"Content" : [] },
						{ "name":"Items",
						   "Content":[] }],
				# VARIABLE QUE GUARDE LOS OBJETOS EN LA PC
			"Medals": {
			  "BOULDERBADGE" : false,
			  "CASCADEBADGE" : true,
			  "THUNDERBADGE" : false,
			  "MARSHBADGE":false
				}
		  }




"""
var player_test = {"name": "Adelina",
			"Sprite":0, 
			"Money":2000,
			"Fighting":true,
			"Pokedex" : [{ "name": "Bulbasaur",
							"Level" : 3,
							"HP" : 40, 
							"Habitat":"Grassland",
							"Nickname": "Blob",
							"Id number":1596863463,
							"Movements" : [{
											"accuracy": 100, 
											"category": "\u7269\u7406", 
											"cname": "\u85e4\u97ad", 
											"ename": "Vine Whip", 
											"id": 22, 
											"jname": "\u3064\u308b\u306e\u30e0\u30c1", 
											"power": 45, 
											"pp": 23,  #25
											"type": "Grass"}
										],
							"In_PC": null,
							"Order_in_fight":0,
							"Objects":null,
							"Experience": 13
						  }, { "name":"Crobat",
							"Level" :10,
							"HP" : 120,
							"Habitat":"Cave",
							"Nickname": "Bat",
							"Id number":3503503928,
							"Movements" : [{
											"accuracy": 100, 
											"category": "\u7269\u7406", 
											"cname": "\u96f7\u5149\u638c", 
											"ename": "Thunder Punch", 
											"id": 9, 
											"jname": "\u304b\u307f\u306a\u308a\u30d1\u30f3\u30c1", 
											"power": 75, 
											"pp": 15, 
											"type": "Electric"
										}, {
											"accuracy": 100, 
											"category": "\u7279\u6b8a", 
											"cname": "\u5341\u4e07\u4f0f\u7279", 
											"ename": "Thunderbolt", 
											"id": 85, 
											"jname": "\uff11\uff10\u307e\u3093\u30dc\u30eb\u30c8", 
											"power": 90, 
											"pp": 15, 
											"tm": 24, 
											"type": "Electric"
						}],
							"In_PC": true,
							"Order_in_fight":null,
							"Objects":null,
							"Experience": 1063
						  },{ "name":"Pikachu",
							"Level" :10,
							"HP" : 30,
							"Habitat":"Forest",
							"Nickname": "",
							"Id number":1444310635,
							"Movements" : [{
											"accuracy": 100, 
											"category": "\u7269\u7406", 
											"cname": "\u96f7\u5149\u638c", 
											"ename": "Thunder Punch", 
											"id": 9, 
											"jname": "\u304b\u307f\u306a\u308a\u30d1\u30f3\u30c1", 
											"power": 75, 
											"pp": 15, 
											"type": "Electric"
										}, {
											"accuracy": 100, 
											"category": "\u7279\u6b8a", 
											"cname": "\u5341\u4e07\u4f0f\u7279", 
											"ename": "Thunderbolt", 
											"id": 85, 
											"jname": "\uff11\uff10\u307e\u3093\u30dc\u30eb\u30c8", 
											"power": 90, 
											"pp": 15, 
											"tm": 24, 
											"type": "Electric"
						}],
							"In_PC": null,
							"Order_in_fight":1,
							"Objects":null,
							"Experience": 1063
						  }
				],
			"Bag":  [{ "name": "Pokeballs",
							"Content" : [["Pokeball",4]]
						  }, { "name":"Key Items",
							"Content" : [] },
						{ "name":"Items",
						   "Content":[] }
				],
			"PC_Objects" : [{ "name": "Pokeballs",
							"Content" : [["Pokeball",4]]
						  }, { "name":"Key Items",
							"Content" : [] },
						{ "name":"Items",
						   "Content":[] }],
				# VARIABLE QUE GUARDE LOS OBJETOS EN LA PC
			"Medals": {
			  "Iron" : false,
			  "Gold" : false,
			  "Rainbow" : false
				}
		  }
"""
var fighting_pokemon = 0
var catching_pokemon = false
var enemy_pokemon_info = []
var pokemon_participate_in_battle = []
var is_colliding_with = null #change to null
var path_trainers = "res://dialogues/trainers.json"
var trainers = (parse_json_files(path_trainers)) #[{"name":"Adel","Name_dialogue":"Trainer 1","Is_in":"ViridianForest","Pokemon":[["Pikachu",5],["Mew",5]],"Is_fighting":0,"Class":"Bird keeper"}]
var number_of_collider = null #VARIABLE FOR THE CHARACTERS INSIDE OF A LIST
var characters = [{"name":"Character","Dialogue":[],"Already_talk":false}] 
#Here is stored the people's speaches
#If its the first time you talk to them then it shows 
#characters["Dialogue"][0] that is a list of dialogue
#if you have talked already with this person and change its number of character
#so it doesnt offer again the same thing or fights again
var current_trainer = null
var rival = [{"name":"Rival","Pokemon":[],"Is_fighting":0,"Class":"Bird keeper","Dialogue":["Yeah! Am I great or what?","WHAT? Unbelievable! I picked the wrong POKEMON!"]}]
var colliding = false
var path = "res://pokedex.json"
var path_movement = "res://moves.json"
var path_habitat = "res://Pokemon_by_place.json"
var is_in = ["beggining","res://Scenes/World/Pallet Town.tscn",Vector2(1,1)]
var path_place = ""
var colliding_character = "1"
var first_time = true #change to true
var first_time_viridian=true #CHANGE TO TRUE
var first_time_cerulean = true #change tot true
var got_pokedex = false #change to false
var battle_finished=[null,null,null,null]
var game_paused = false
var positions_to_play=[{"Is_in0":"MtMoon","Is_in1":"res://Scenes/World/Mountain Moon.tscn","Positions":[Vector2(215.35,-145.2),Vector2(725.26,-94.53),Vector2(1419.382,36.279)],"Player_position":[Vector2(141.178,-256.276),Vector2(1153.239,-512.855),Vector2(1930.103,50.193)]},{"Is_in0":"MtMoon","Is_in1":"res://Scenes/World/Mountain Moon 2.tscn","Positions":[Vector2(349.479,-190.855),Vector2(1315.213,-237.182),Vector2(695.147,482.664),Vector2(1058.634,90.669)],"Player_position":[Vector2(141.178,-256.276),Vector2(1153.239,-512.855),Vector2(1930.103,50.193),Vector2(1933.666,-658.962)]},{"Is_in0":"MtMoon","Is_in1":"res://Scenes/World/Mountain Moon 3.tscn","Positions":[Vector2(176.819,-357.822), Vector2(1183.682,-618.528), Vector2(1941.825,-76.141), Vector2(2142.598,-651.49), Vector2(575.369,55.71), Vector2(767.152,-480.683), Vector2(1369.472,592.104), Vector2(1786.001,-609.538)],"Player_position":[Vector2(200.225,-42.684), Vector2(864.225,-114.684), Vector2(1492.225,133.316), Vector2(1015.518,241.095), Vector2(346.08,-72.571), Vector2(1368.61,-136.479), Vector2(827.073,492.511), Vector2(1190.34,82.154)]},{"Is_in0":"Route3","Is_in1":"res://Scenes/World/Routes/Route 4.tscn","Positions":[Vector2(531.229,211.335)],"Player_position":[Vector2(668.225,609.316)]}]
var pokemon_rival = "Charmander"
var room_in_ss_anne=1
var first_time_anne = true #CHANGE TO TRUE
var first_time_tower = true #CHANGE TO TRUE
var defeated_marowak = false #change to false
var can_cross_tunnel = false #change to false
var first_time_hideout = true
var defeated_team_rocket = false #change to false
var dialogue=load("res://dialogues/dialogues.tres")
var current_dialogue = dialogue.beggining

func _ready() -> void:
	randomize()
	#set_every_dialogue_name()
	#resource.duplicate()
	#var dialogues=load("res://dialogues/dialogues_cerulean.tres")
	#dialogues.dialogues[2]["Already_talk"]=true
	#print(dialogues.diastlogues[2])
	#ResourceSaver.save("res://dialogues/dialogues_cerulean.tres", dialogues)
	#print (b[pos])
	#var archivo2 = parse_json_files("res://dialogues/PokemonDialoguesPalletTown.json")
	#var file = File.new()
	#var err = file.open("user://PRUEBA.txt", File.WRITE)
	#file.store_line(String(player_test))
	#file.close()
	
	#var resource = Resource.new()
	#resource.resource_path = "user://resource.tres"
	#ResourceSaver.save("res://player_info.tres",resource,0)


func set_every_dialogue_name(city):
	var dialogues = city
	for x in range(len(dialogues)):
		for sentences in dialogues[x]["Dialogue"]:
			if "Rival" in sentences:
				for i in range(len(dialogues[x]["Dialogue"])):
					var pos = (dialogues[x]["Dialogue"][i].find("Rival"))
					if pos==-1:
						pass
					else:
						var name = rival[0]["name"]
						dialogues[x]["Dialogue"][i] = dialogues[x]["Dialogue"][i].replace("Rival",name)
						#for z in range(len(name)):
							#dialogues[x]["Dialogue"][i][(pos+z)]=name[z]
					ResourceSaver.save("res://dialogues/dialogues.tres",dialogue)
			if "Player" in sentences:
				for i in range(len(dialogues[x]["Dialogue"])):
					var pos = (dialogues[x]["Dialogue"][i].find("Player"))
					if pos==-1:
						pass
					else:
						var name = player_test["name"]
						dialogues[x]["Dialogue"][i] = dialogues[x]["Dialogue"][i].replace("Player",name)
						#dialogues[x]["Dialogue"][i].replacen("Player",name)
						#for z in range(len(name)):
						#	if z<=len(name)-1 and len(name)==7:
						#		dialogues[x]["Dialogue"][i][(pos+z)]=name[z]
						#	elif z==len(name)-1 and len(name)<7:
						#		dialogues[x]["Dialogue"][i][(pos+z)]=name[z]
						#		var left = 7-len(name)-1
						#		for y in range(left,7):
						#			dialogues[x]["Dialogue"][i][pos+y]=" "
					ResourceSaver.save("res://dialogues/dialogues.tres",dialogue)
	

func player_id()->int:
	var date = OS.get_datetime()
	var year = date["year"]
	var month = date["month"]
	var day = date["day"]
	var hour = date["hour"]
	var minute = date["minute"]
	var second = date["second"]
	var to_hash = player_test["name"] + String(player_test["Sprite"])+ String(second)+String(minute)+String(hour)+String(day)+String(month)+String(year)
	var output = hash(to_hash)
	print (output)
	return (output)

func rewrite():
	var save_game = File.new()
	var dict = {
		"player_info": "HOLA THIS IS A TRY",
		"Time saved":"YESTERDAY"}
	save_game.open("user://savegame.save", File.READ_WRITE)
	var node_data = {}
	node_data = parse_json(save_game.get_as_text())
	#while save_game.get_position() < (save_game).get_len():
		#node_data = parse_json(save_game.get_line())
	print (node_data)
	node_data["OTHER THINGS"] = "ADE ADE"
	#node_data["NEW"] = dict
	save_game.store_line(to_json(node_data))
	save_game.close()


func save_game():
	var save_game = File.new()
	var date = OS.get_datetime()
	var dict2 = {"HOLA":"NO SIRVO"}
	var dict = {
		"player_info": player_test,
		"Time saved":String(date["day"])+"/"+String(date["month"])+"/"+String(date["year"]),
		"pallet":first_time,
		"viridian":first_time_viridian,
		"cerulean":first_time_cerulean,
		"has_pokedex":got_pokedex,
		"paused":game_paused,
		"pokemon_rival":pokemon_rival,
		"anne_room":room_in_ss_anne,
		"anne":first_time_anne,
		"tower":first_time_tower,
		"Current_dialogue":current_dialogue,
		"Is in": is_in,
		"Dialogues":[
			dialogue.beggining,
			dialogue.pallet_town,
			dialogue.route1,
			dialogue.viridian_city,
			dialogue.route2,
			dialogue.pewter_city,
			dialogue.route3,
			dialogue.mt_moon,
			dialogue.route4,
			dialogue.cerulean_city,
			dialogue.route24,
			dialogue.route25,
			dialogue.route5,
			dialogue.route6,
			dialogue.vermilion_city,
			dialogue.route9,
			dialogue.route10,
			dialogue.lavender_town,
			dialogue.route8,
			dialogue.celadon_city,
			dialogue.route11,
			dialogue.route7,
			dialogue.saffron_city
		]}
	var data = {}
	if save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.READ_WRITE)
		print (save_game.get_len(),"TAMANO CUANDO VA A ENTRAR AL LOOP")
		while save_game.get_position()<save_game.get_len():
			data = parse_json(save_game.get_line())
		print (data)
		data.append(dict)
		save_game.open("user://savegame.save", File.WRITE_READ)
		save_game.store_string(to_json(data))
	elif not save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.WRITE)
		#data["SOMETHING"] = dict
		save_game.store_line(to_json([dict]))
	save_game.close()


func load_game(pos)->Dictionary:
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return ({})
	save_game.open("user://savegame.save", File.READ)
	var data = {}
	while save_game.get_position()<save_game.get_len():
		data = parse_json(save_game.get_line())
	print (save_game.get_len())
	if pos==-1:
		pass
	else:
		var info = data[pos]
		player_test=info["player_info"]
		first_time=info["pallet"]
		first_time_viridian=info["viridian"]
		first_time_cerulean=info["cerulean"]
		got_pokedex=info["has_pokedex"]
		game_paused=info["paused"]
		pokemon_rival=info["pokemon_rival"]
		room_in_ss_anne=info["anne_room"]
		first_time_anne=info["anne"]
		first_time_tower=info["tower"]
		current_dialogue=info["Current_dialogue"]
		is_in=info["Is in"]
		dialogue.beggining=info["Dialogues"][0]
		dialogue.pallet_town=info["Dialogues"][1]
		dialogue.route1=info["Dialogues"][2]
		dialogue.viridian_city=info["Dialogues"][3]
		dialogue.route2=info["Dialogues"][4]
		dialogue.pewter_city=info["Dialogues"][5]
		dialogue.route3=info["Dialogues"][6]
		dialogue.mt_moon=info["Dialogues"][7]
		dialogue.route4=info["Dialogues"][8]
		dialogue.cerulean_city=info["Dialogues"][9]
		dialogue.route24=info["Dialogues"][10]
		dialogue.route25=info["Dialogues"][11]
		dialogue.route5=info["Dialogues"][12]
		dialogue.route6=info["Dialogues"][13]
		dialogue.vermilion_city=info["Dialogues"][14]
		dialogue.route9=info["Dialogues"][15]
		dialogue.route10=info["Dialogues"][16]
		dialogue.lavender_town=info["Dialogues"][17]
		dialogue.route8=info["Dialogues"][18]
		dialogue.celadon_city=info["Dialogues"][19]
		dialogue.route11=info["Dialogues"][20]
		dialogue.route7=info["Dialogues"][21]
		dialogue.saffron_city=info["Dialogues"][22]
		ResourceSaver.save("res://dialogues/dialogues.tres", dialogue)
	#COLOCAR LAS COSAS EN SU LUGAR
	save_game.close()
	return(data)


func show_right_dialogue(area):
	var arr = current_dialogue
	var pos = null
	for x in range(len(arr)):
		if arr[x]["name"]==area.number_of_character_in_dialogue:
			pos = x
	if area.trainer_npc == true and arr[pos]["Already_talk"]==true:
		area.number_of_character_in_dialogue += " after"
		area.trainer_npc = false
		area.regular_character = true
	elif area.receive_gift_from_npc == true and arr[pos]["Already_talk"]==true:
		area.number_of_character_in_dialogue += " after"
		area.receive_gift_from_npc = false
		area.regular_character = true
	else:
		pass
		

func find_rival_pokemon()->Dictionary:
	var current = {}
	var archive = parse_json_files("res://dialogues/rival_pokemon.json")
	if is_in[0]=="PalletTown":
		current = archive[0][pokemon_rival]
	elif is_in[0]=="CeruleanCity":
		current = archive[1][pokemon_rival]
	elif is_in[0]=="VermilionCity":
		current = archive[2][pokemon_rival]
	elif is_in[0]=="LavenderTown":
		current = archive[3][pokemon_rival]
	current["name"]=rival[0]["name"]
	return (current)

func find_player_pos()->Vector2:
	var pos_=null
	for x in range(len(positions_to_play)):
		if positions_to_play[x]["Is_in0"]==PlayerData.is_in[0] and positions_to_play[x]["Is_in1"]==PlayerData.is_in[1]:
			pos_=x
	var pos = PlayerData.is_in[2]
	var insert = null
	var arr=[]
	for y in range(len(positions_to_play[pos_]["Positions"])):
		insert = (positions_to_play[pos_]["Positions"][y]-pos).length()
		arr.append(insert)
	var b = arr.min()
	var resultado = null
	for x in range(len(arr)):
		if arr[x]==b:
			resultado=x
	print (resultado)
	var output=positions_to_play[pos_]["Player_position"][resultado]
	return (output)



func find_trainer(name_in_dialogues,whereisit)->Dictionary:
	var a={}
	var pos=null
	for x in range(len(trainers)):
		if trainers[x]["Name_dialogue"]==name_in_dialogues and trainers[x]["Is_in"]==whereisit:
			pos=x
		else:
			x+=1
	a=trainers[pos]
	return (a)

func set_tile_dialogue(id)->String:
	var collide = null
	if id==35 or id==58:
		pass #ESTANTE EN EL POKEMALL
	elif id==70:
		pass #BROKEN BIBLIOTECA EN LA CASITA
	elif id==100 and PlayerData.is_in[0]!="Route25":
		pass #celadon city pc with book
	elif id ==101:
		pass #celadon city estante azul con verde
	elif id==102:
		pass #COSITO DEL ASCENSOR
	elif id==107 or id==108 or id==109:
		pass #PC AT TEAM ROCKET HIDEOUT
	elif id==0:
		pass #PLAYERPC
	elif id==11:
		pass #TO DO LIST AT PLAYERS HOUSE
	elif id==12 or id==13:
		pass #machines at oaks lab
	elif id==19:
		pass #big machine at oaks lab
	elif id==2:
		pass #estante verde
	elif id==5:
		pass #Cocina de las casitas
	elif id==6:
		pass #vitrina de madera
	elif id==7:
		pass #marquito rojo con lista
	elif id==46:
		collide = "Gym Plaque"
	elif id==41:
		collide = "Exhibit A"
	elif id==45:
		collide ="Exhibit D"
	elif id==43:
		collide="Museum 2 Pedestal"
	elif id==23:
		collide = "Blackboard"
	elif id==8:
		collide = "SNES" #NES
	elif id==28:
		collide="Notebook"
	elif id==9:
		collide = "Television" #TV
	elif id==29:
		collide = "Map" #MAPA
	elif id==31:
		collide = "PC"
	elif id==39:
		collide = "PokemonCenter" #POKEMON CENTER
	elif id==100 and PlayerData.is_in[0]=="Route25":
		collide = "Machine"
	if collide!=null and id!=39 and id!=31:
		is_colliding_with=4
		colliding_character = collide
	elif collide!=null and id==39 and id!=31:
		is_colliding_with=0
		colliding_character = collide
	elif collide!=null and id!=39 and id==31:
		is_colliding_with=1
		colliding_character = collide
	else:
		pass
	return (collide)

func place(city)->String:
	var variable = ""
	if city=="PalletTown":
		variable = "res://dialogues/PokemonDialoguesPalletTown.json"
	elif city=="Route1":
		variable = "res://dialogues/PokemonDialoguesRoute1.json"
	elif city =="ViridianCity":
		variable = "res://dialogues/PokemonDialoguesViridianCity.json"
	elif city =="beggining":
		variable = "res://dialogues/PokemonDialoguesbeggining.json"
	elif city=="Route2" or city=="ViridianForest":
		variable = "res://dialogues/PokemonDialoguesViridianForestandRoute2.json"
	elif city == "PewterCity":
		variable = "res://dialogues/PokemonDialoguesPewterCity.json"
	elif city =="Route3":
		variable = "res://dialogues/PokemonDialoguesRoute3.json"
	elif city=="MtMoon":
		variable = "res://dialogues/PokemonDialoguesMtMoon.json"
	elif city == "CeruleanCity":
		variable = "res://dialogues/PokemonDialoguesCeruleanCity.json"
		#dialogue=load("res://dialogues/dialogues.tres")
	elif city == "Route24":
		variable = "res://dialogues/PokemonDialoguesRoute24.json"
	elif city == "Route6":
		variable = "res://dialogues/PokemonDialoguesRoute6.json"
	elif city =="VermilionCity":
		variable = "res://dialogues/PokemonDialoguesVermilionCity.json"
	elif city=="Route5":
		variable = "res://dialogues/PokemonDialoguesRoute5.json"
	elif city=="Route25":
		variable = "res://dialogues/PokemonDialoguesRoute25.json"
	return (variable)


#var dialogues = parse_json_files(place(is_in[0]))

func update_dialogue():
	pass #dialogues = parse_json_files(place(is_in[0]))


func find_npc_dialogue()->Dictionary:
	#var path_place = place(is_in[0])
	#update_dialogue()
	var dialogues = current_dialogue
	#var dialogue=load("res://dialogues/dialogues_cerulean.tres")
	#var dialogues = parse_json_files(path_place) #dialogue.dialogues #
	var found = {}
	for x in range(len(dialogues)):
		if dialogues[x]["name"] == colliding_character:
			found = dialogues[x]
			break
		else:
			x+=1
	return (found)
	
func hashing(name, level, nickname) -> int:
	var to_hash = name + nickname + String(level)	
	var output = hash(to_hash)
	print (output)
	return (output)
	
func get_pokemon_habitat(name)->String:
	var habitats = parse_json_files(path_habitat)
	var pokemon_habitat = null
	for x in range(len(habitats)):
		for names in habitats[x]["Grassland"]:
			if names == name:
				pokemon_habitat = "Grassland"
		for names in habitats[x]["Forest"]:
			if names == name:
				pokemon_habitat = "Forest"
		for names in habitats[x]["Water's edge"]:
			if names == name:
				pokemon_habitat = "Water's edge"
		for names in habitats[x]["Sea"]:
			if names == name:
				pokemon_habitat = "Sea"
		for names in habitats[x]["Cave"]:
			if names == name:
				pokemon_habitat = "Cave"
		for names in habitats[x]["Mountain"]:
			if names == name:
				pokemon_habitat = "Mountain"
		for names in habitats[x]["Rough-terrain"]:
			if names == name:
				pokemon_habitat = "Rough-terrain"
		for names in habitats[x]["Urban"]:
			if names == name:
				pokemon_habitat = "Urban"
		for names in habitats[x]["Rare"]:
			if names == name:
				pokemon_habitat = "Rare"
	return (pokemon_habitat)

func heal_pokemon():
	for x in range(len(player_test["Pokedex"])):
		var name = player_test["Pokedex"][x]["name"]
		var info_name = get_pokemon_info_by_name(name)
		var HP = info_name[2]["HP"]
		player_test["Pokedex"][x]["HP"] = HP
		for i in range (len(player_test["Pokedex"][x]["Movements"])):
			var Movement = player_test["Pokedex"][x]["Movements"][i]
			var maximum_pp = get_max_movement_pp(Movement)
			player_test["Pokedex"][x]["Movements"][i]["pp"] = maximum_pp


func find_pos()->int:
	var position = null
	for x in range(len(player_test["Pokedex"])):
		if player_test["Pokedex"][x]["Order_in_fight"] == fighting_pokemon:
			position = x
			#for i in range(len(player_test["Pokedex"][x]["Movements"])):
				#arrays.append(player_test["Pokedex"][x]["Movements"][i])
		else:
			position = null
	return (position)
#fighting belongs to order of fighting no el numero que esta aqui poer
#que eso es la posicion del pokemon
func get_player_attacks()-> Array:
	var arrays = []
	var position = 0 #null #ahhh this should be null
	#THE FOLLOWING FOR SHOULD BE DELETED IF THIS WORKS OK
	for x in range(len(player_test["Pokedex"])):
		if player_test["Pokedex"][x]["Order_in_fight"] == fighting_pokemon: #fighting_pokemon
			position = x
			#for i in range(len(player_test["Pokedex"][x]["Movements"])):
				#arrays.append(player_test["Pokedex"][x]["Movements"][i])
	
	#	else:
	#		pass
	print ("THIS IS THE POKEMON POSITION", position)
	#var movements = parse_json_files(path_movement)
	var output = player_test["Pokedex"][position]["Movements"]
	#for i in range(len(arrays)):
	#	for x in range(len(movements)):
	#		if movements[x]["ename"] == arrays[i]:
	#			output.append(movements[x])
	var a = get_pokemon_info_by_name(player_test["Pokedex"][position]["name"])
	var lists = [player_test["Pokedex"][position]["name"],a,output,position]
	return (lists)


func new_battle_trainer() -> Array:
	var enemies = parse_json_files(path)
	# CHOOSE AN ENEMY
	var enemy_pokemon = null
	var pos = current_trainer["Is_fighting"]
	for x in range (len(enemies)):
		if enemies[x]["name"]["english"] == current_trainer["Pokemon"][pos][0]:
			enemy_pokemon = enemies[x]
		pass
	print (enemy_pokemon)
	#CHOOSE ITS MOVEMENTS
	var move = parse_json_files(path_movement)
	var enemy_movements = []
	for x in range(0,len(move)):
		if String(move[x]["type"]) == String(enemy_pokemon["type"][0]):
			enemy_movements.append(move[x]) # A VECES NO TOMA MOVIMIENTOS ARREGLAR
	var enemy_attack = []
	for x in range(0,4):
		enemy_attack.append(enemy_movements[randi() % len(enemy_movements)])
	var lists = [enemy_pokemon,enemy_attack,current_trainer["Pokemon"][pos][1]]
	return (lists)

func new_battle() -> Array:
	var enemies = parse_json_files(path)
	# CHOOSE AN ENEMY
	var enemy_pokemon = enemies[randi() % 150]
	print (enemy_pokemon)
	#CHOOSE ITS MOVEMENTS
	var move = parse_json_files(path_movement)
	var enemy_movements = []
	for x in range(0,len(move)):
		if String(move[x]["type"]) == String(enemy_pokemon["type"][0]):
			enemy_movements.append(move[x]) # A VECES NO TOMA MOVIMIENTOS ARREGLAR
	var enemy_attack = []
	for x in range(0,4):
		enemy_attack.append(enemy_movements[randi() % len(enemy_movements)])
	var lists = [enemy_pokemon,enemy_attack,(randi() % 99)]
	return (lists)
	
	
func parse_json_files(json_file_path)->Array:
	var data = {}
	var jsonfile = File.new()
	jsonfile.open(json_file_path, File.READ)
	data = parse_json(jsonfile.get_as_text())
	return (data)
	
func get_pokemon_info_by_name(name)->Array:
	var data = parse_json_files(path)
	var id = null
	var type = null
	var base = null
	for x in range(len(data)):
		if data[x]["name"]["english"] == name:
			id = data[x]["id"]
			type = data[x]["type"]
			base = data[x]["base"]
		else:
			pass
	var list = [id,type,base]
	return (list)
			
			


func to_fight_pokemon() -> int:
	var pokemon_number = null
	for x in range(len(player_test["Pokedex"])):
		if (player_test["Pokedex"][x]["Order_in_fight"] == 0 and player_test["Pokedex"][x]["HP"] != 0) or (player_test["Pokedex"][x]["Order_in_fight"] == 1 and player_test["Pokedex"][x]["HP"] != 0) or (player_test["Pokedex"][x]["Order_in_fight"] == 2 and player_test["Pokedex"][x]["HP"] != 0) or (player_test["Pokedex"][x]["Order_in_fight"] == 3 and player_test["Pokedex"][x]["HP"] != 0):
			pokemon_number = x
		else:
			pokemon_number = null
	return (pokemon_number)

#var path = "res://PRUEBA.json"
#var data ={}
"""
func _ready() -> void:
	#new_player("Adelina")
	var jsonfile = File.new()
	var a = jsonfile.open(path, File.READ)
	data = parse_json(jsonfile.get_as_text())  
	print(data)
	print(data[0])
	print(data[0]["Bag"])
	print(data[0]["Pokedex"])
	print(data[0]["name"])
	new_player_("Adelina",0)
	
	print ("THIS IS PRINTING",player_data)
"""

func new_player_(name,sprite)->void:
	player_data["name"] = name
	player_data["Sprite"] = sprite
	"""
	dictionary["Pokedex"]["Pikachu"] = {   
					"Level" : 12,   
					"HP" : 120,  
					"Movements" : ["Electric"]  
						
				  } 
	print (dictionary["Pokedex"])
	dictionary["Bag"]["Potion"] = 2
	print (dictionary["Bag"])
	"""
	
	

"""
func new_player(name)->void:
	var file = File.new()
	file.open("res://player_data.json", File.WRITE)
	var json_text = String(
		[{ 
			"name": name, 
			
			"Pokedex" : {    
			  "Bulbasaur": {   
					"Level" : 3,   
					"HP" : 100,  
					"Movements" : ["Vine Whip"]  
						
				  } 
			},
			"Bag": {
			  "Pokeball": 4
			},
			"Medals": {
			  "Iron" : false,
			  "Gold" : false,
			  "Rainbow" : false
				}
		  }
		])
	file.store_string(json_text)
	file.close()
	#create a new json file
	#record the name of the new player
	# add the pokemons
"""

func newpokemon(name, level, HP, movements, experience,nickname):
	var maximum = 0
	var order_fight = null
	var in_pc = null
	for x in range(len(player_test["Pokedex"])):
		if player_test["Pokedex"][x]["Order_in_fight"] == null:
			x+=1
		if player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = player_test["Pokedex"][x]["Order_in_fight"]
	if maximum < 3:
		if maximum!=0:
			order_fight = maximum + 1
		elif maximum==0:
			order_fight = 0
		in_pc = null
	else:
		order_fight = null
		in_pc = true
	var moves = []
	for x in range(len(movements)):
		moves.append(movements[x]["ename"])
	var NEW_POKEMON = {"name":name,
						"Level" : level,
						"HP" : HP,
						"Habitat":get_pokemon_habitat(name),
						"Nickname": "", #CHANGE THIS
						"Id number":hashing(name, level, nickname), #CHANGE THIS
						"Movements" : movements,
						"In_PC": in_pc,
						"Order_in_fight":order_fight,
						"Objects":null,
						"Experience": experience}
	player_test["Pokedex"].append(NEW_POKEMON)
	#adds a pokemon to the file when the player catches it

func get_max_movement_pp(move)->int:
	var data = parse_json_files(path_movement)
	var num = null
	for x in range(len(data)):
		if data[x]["ename"] == move["ename"]:
			num = x
	var pp = data[num]["pp"]
	return (pp)
	
var file = load("res://assets/pokemon_battle/battle_beggining/pokemons.tres")

func set_pokemon_sprite(SPRITE,id,on_fight_player):
	var texture = file.duplicate()
	SPRITE.texture = texture
	var x=164
	var multiplier = ceil(id/15.0)-1
	#(id/15)-1
	#if id <= 15:
	#	multiplier = 0
	#elif 15<id and id<=30:
	#	multiplier = 1
	#elif 30<id and id<=45:
	#	multiplier = 2
	#elif 45<id and id<=60:
	#	multiplier = 3
	#elif 60<id and id<=75:
	#	multiplier = 4
	#elif 75<id and id<=90:
	#	multiplier = 5
	#elif 90<id and id<=105:
	#	multiplier = 6
	#elif 105<id and id<=120:
	#	multiplier = 7
	#elif 120<id and id<=135:
	#	multiplier = 8
	#elif 135<id and id<=150:
	#	multiplier = 9
	#else:
	#	multiplier = 10
	#var quantity = null
	var quantity = (15 * multiplier) + 1
	#print ('Quantity',quantity)
	texture.set_region(Rect2(10.571,43.95+x*multiplier,1950.353,130.486))
	SPRITE.hframes = 30
	SPRITE.vframes = 2	
	var position = null
	if on_fight_player == true:
		position = (id - quantity) * 2 + 30
	if on_fight_player == false:
		position = (id - quantity) * 2
	SPRITE.frame = position

func adds_pokemon_to_pc():
	#adds a pokemon to the correct place according to where it was captured
	pass

func change_pokemon_pp():
	#change the HP and pp thats left on a pokemon
	pass

func set_data(name:String) -> void:
	player_data = {"name": name,
			"Sprite":0, 
			"Money":0,
			"Pokedex" : { },
			"Bag": { },
			"Medals": {
			  "Iron" : false,
			  "Gold" : false,
			  "Rainbow" : false
				}
		  }
	emit_signal("player_data_updated")

	

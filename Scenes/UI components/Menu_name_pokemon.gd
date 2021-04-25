extends Control
var enemy_attacks = PlayerData.enemy_pokemon_info
var dictionaries = {1:"A",2:"B",3:"C",6:"D",7:"E",8:"F",10:"G",11:"H",12:"I",15:"J",16:"K",17:"L",19:"M",20:"N",21:"O",24:"P",25:"Q",26:"R",27:"S",28:"T",29:"U",30:"V",33:"W",34:"X",35:"Y",36:"Z"}
var player_name = ["","","","","","",""]
onready var pokemon=get_node("pokemon")
signal playername(value)
var playername = "" setget setplayername
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.set_pokemon_sprite(pokemon,enemy_attacks[0]["id"],false)
	$selector.position = position_of_letter(1)

func setplayername(value):
	playername = value
	emit_signal("playername",playername)
	
func position_of_letter(number)->Vector2:
	var row = ceil(number/9.0)-1 
	var column = number%9 -1
	if column == -1:
		column = 8
	var x= 125.84+column*53
	var y=302.704+row*67
	var aux =127.356
	if number<12:
		aux = 0
	print (row,"ROWS",column,"COLUMNS", number,"LETRA")
	#x = (x + x*( (number-1) / 7) + aux)
	#y = (y + y* ((number-1) % 3 ))
	var pos = Vector2(x,y)
	return (pos)
	
var pos=1
var dir_selector=position_of_letter(pos)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right"):
		if pos>=36:
			pos=0
		$selector.position = position_of_letter(pos+1)
		pos+=1
	elif event.is_action_pressed("left"):
		if pos<=1:
			pos=37
		$selector.position = position_of_letter(pos-1)
		pos-=1
	elif event.is_action_pressed("down"):
		if pos>=28:
			pos=pos-4*9
		$selector.position = position_of_letter(pos+9)
		pos=pos+9
	elif event.is_action_pressed("up"):
		if pos<=9:
			pos=pos+4*9
		$selector.position = position_of_letter(pos-9)
		pos=pos-9
	elif event.is_action_pressed("ui_accept"):
		input_event_entered()
	elif event.is_action_pressed("delete"):
		delete_letter()
	elif event.is_action_pressed("space"):
		self.playername = player_name[0]+player_name[1]+player_name[2]+ player_name[3]+player_name[4]+ player_name[5]+ player_name[6]
		var nickname = playername
		var experience = (int(floor(4*pow(enemy_attacks[2],3) / 5)))
		PlayerData.newpokemon(enemy_attacks[0]["name"]["english"], enemy_attacks[2], PlayerData.enemy_pokemon_info[0]["base"]["HP"], enemy_attacks[1], experience,nickname)
		get_tree().change_scene(PlayerData.is_in[1])
		
		
var name_p=[]
func input_event_entered():
	$Label.text = String(pos)
	for x in range(len(player_name)):
		if player_name[x]=="":
			player_name[x]=dictionaries[pos]
			break
		else:
			x+=1
	if len(name_p)<7:
		name_p.append(dictionaries[pos])
	$Label.text = dictionaries[pos]
	
func delete_letter():
	for x in range(len(player_name)-1,-1,-1):
		if player_name[x]!="":
			player_name[x]=""
			break
		else:
			x-=1
	
	
func _process(delta: float) -> void:
	$Label.text = player_name[0] + "   " + player_name[1]+ "   " + player_name[2]+ "   " + player_name[3]+ "   " + player_name[4]+ "   " + player_name[5]+ "   " + player_name[6]


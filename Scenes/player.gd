extends Area2D
signal colliding(value)
var collider = false setget setcollision
var tile_size = 5
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}
onready var sprite = $Sprite
onready var ray = $RayCast2D
var data ={}
var path = "res://pokedex.json"
var player = null
var direction = ""
var moving = true
onready var dialogue = get_node("CanvasLayer/Dialogue")
func _ready() -> void:
	dialogue.visible = false
	sprite.animation = "walking down " + String(PlayerData.player_test["Sprite"])
	sprite.frame = PlayerData.player_test["Sprite"]
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	if PlayerData.player_test["Sprite"] == 0:
		player = "0"
	else:
		player = "1"
	print (PlayerData.game_paused,"PAUSADO")
	if PlayerData.game_paused==true:
		$"Pause menu".paused=true
		$"Pause menu"._init()
	elif PlayerData.game_paused==false:
		pass

func _unhandled_input(event):
	for dir in inputs.keys():
		if Input.is_action_pressed("left") and (Input.is_action_pressed("up") or Input.is_action_pressed("down"))  and moving==true:
			dir="left"
			move(dir)
		elif Input.is_action_pressed("right") and (Input.is_action_pressed("up") or Input.is_action_pressed("down"))  and moving==true:
			dir="right"
			move(dir)
		elif Input.is_action_just_pressed(dir) and moving==true:
			if dir == "left":
				sprite.animation = "walking left " + player
				sprite.flip_h = false
				sprite.offset.y = -1
				sprite.offset.x = 0
			elif dir == "right":
				sprite.animation = "walking left " + player
				sprite.flip_h = true
				sprite.offset.y = -1
				sprite.offset.x = -17
			elif dir == "up":
				sprite.flip_h = false
				sprite.animation = "walking up " + player
				if PlayerData.player_test["Sprite"]==1:
					sprite.offset.y = 3
				else:
					sprite.offset.y = 0
				sprite.offset.x = 0
			elif dir == "down":
				sprite.flip_h = false
				sprite.animation = "walking down " + player
				if PlayerData.player_test["Sprite"]==1:
					sprite.offset.y = 5
				else:
					sprite.offset.y = -4
				sprite.offset.x = 0
		elif Input.is_action_pressed(dir) and moving==true:
			if dir == "left":
				sprite.animation = "walking left " + player
				sprite.flip_h = false
			elif dir == "right":
				sprite.animation = "walking left " + player
				sprite.flip_h = true
			elif dir == "up":
				sprite.animation = "walking up " + player
			elif dir == "down":
				sprite.animation = "walking down " + player
			move(dir)
			sprite.playing = true
			direction = dir
		if Input.is_action_just_released(dir) and moving==true:
			sprite.playing = false
		if Input.is_action_pressed(dir) and moving==false:
			sprite.playing = false

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += inputs[dir] * tile_size


var is_inside = null
func _on_player_body_entered(body: Node) -> void:
	pass
		
var stop_moving=false
var dont_show_dialogue = false
func _process(delta: float) -> void:
	#moving = not (dialogue.is_visible_in_tree())
	if stop_moving == true and dont_show_dialogue == false:
		dialogue.visible=true
		moving = not stop_moving
	elif stop_moving==false and dont_show_dialogue==false:
		moving = not (dialogue.is_visible_in_tree())
	elif dont_show_dialogue == true and stop_moving==true:
		dialogue.hide()
		moving = not stop_moving
	if dialogue.finished == true and PlayerData.colliding_character == "Oak":
		self.collider = dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character == "Clerk":
		self.collider = dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character == "Oak_parcel":
		self.collider = dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "Getting_pokedex":
		self.collider = dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "3" or PlayerData.colliding_character== "3_after":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "4" or PlayerData.colliding_character== "4_after":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "Museum 1 Scientist1":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "Rival_leave_lab":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "Captain":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "Machine":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character== "Trainer 1 after" and PlayerData.is_in[0]=="CeruleanCity":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character=="Rival_Fight after":
		self.collider =dialogue.finished
	elif dialogue.finished == true and PlayerData.colliding_character=="Giovanni after":
		self.collider = dialogue.finished

func _on_player_area_entered(area: Area2D) -> void:
	if area.name == "Ball 1" or area.name == "Ball 2" or area.name == "Ball 3" or area.name == "Inside objects" or area.name=="not_able_to_cross":
		pass
	else:
		dialogue._init()
		dialogue.visible = true
		self.collider = dialogue.finished
	
func setcollision(value):
	collider = value
	emit_signal("colliding",collider)

func _on_Pause_menu_is_paused(value):
	stop_moving=value
	PlayerData.game_paused=value
	$CanvasLayer/Dialogue.visible = value



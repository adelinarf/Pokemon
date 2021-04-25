extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var directionx = [Vector2(16,13),Vector2(151,13)]
var directiony = [Vector2(16,34),Vector2(151,33.5)]
var posx = 0
onready var move1 = get_node("move1")
onready var move2 = get_node("move2")
onready var move3 = get_node("move3")
onready var move4 = get_node("move4") 
var nearest = ""
var move = 0

signal selected_by_key(value)
signal show_move(value)
var selected_move = "" setget set_selected
var selected = "" setget set_move_to_show
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.selected = null
	self.selected_move=null

func _process(delta):
	if visible:
		set_process_unhandled_input(true)
	elif not visible:
		set_process_unhandled_input(false)
		
func input_event_entered():
	var move1_length = (move1.rect_position - $selector.rect_position).length()
	var move2_length = ((move2.rect_position - $selector.rect_position).length())
	var move3_length = ((move3.rect_position - $selector.rect_position).length())
	var move4_length = ((move4.rect_position - $selector.rect_position).length())
	var lengths = [move1_length,move2_length,move3_length,move4_length]
	for x in range(len(lengths)):
		if lengths.min() == move1_length:
			nearest = move1.text
			move = 0
		elif lengths.min() == move2_length:
			nearest = move2.text
			move = 1
		elif lengths.min() == move3_length:
			nearest = move3.text
			move = 2
		elif lengths.min() == move4_length:
			nearest = move4.text
			move = 3

func _unhandled_input(event: InputEvent) -> void:
	input_event_entered()
	if event.is_action_pressed("left"):
		if $selector.rect_position == directionx[(posx)%len(directionx)]:
			$selector.rect_position = directionx[(posx+1)%len(directionx)]
		if $selector.rect_position == directiony[(posx)%len(directiony)]:
			$selector.rect_position = directiony[(posx+1)%len(directiony)]
		posx+=1
	elif event.is_action_pressed("right"):
		if $selector.rect_position == directionx[(posx)%len(directionx)]:
			$selector.rect_position = directionx[(posx-1)%len(directionx)]
		if $selector.rect_position == directiony[(posx)%len(directiony)]:
			$selector.rect_position = directiony[(posx-1)%len(directiony)]
		posx+=1
	elif event.is_action_pressed("up"):
		if $selector.rect_position == directionx[(posx)%len(directionx)]:
			$selector.rect_position = directiony[(posx)%len(directiony)]
		elif $selector.rect_position == directiony[(posx)%len(directiony)]:
			$selector.rect_position = directionx[(posx)%len(directionx)]
	elif event.is_action_pressed("down"):
		if $selector.rect_position == directionx[(posx)%len(directionx)]:
			$selector.rect_position = directiony[(posx)%len(directiony)]
		elif $selector.rect_position == directiony[(posx)%len(directiony)]:
			$selector.rect_position = directionx[(posx)%len(directionx)]
	if event.is_action_pressed("ui_accept"):
		#nput_event_entered()
		print ("IM ENTER IN THE MENU MOVES")
		self.selected_move = move
	#input_event_entered()
	if nearest == "":
		pass
	else:
		self.selected = nearest
		#self.selected_move = move

func set_selected(value):
	selected_move = value
	emit_signal("selected_by_key",selected_move)
	
func set_move_to_show(value):
	selected = value
	emit_signal("show_move",selected)

extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var directionx = [Vector2(5.879,13.879),Vector2(86.879,13.879)]
var directiony = [Vector2(5.879,38.879),Vector2(86.879,38.879)]
var posx = 0
onready var fight = get_node("Fight")
onready var pokemon = get_node("Pokemon")
onready var bag = get_node("Bag")
onready var run = get_node("Run") 
var nearest = ""

signal selected_by_key(value)
var selected = "" setget set_selected 
var is_enemy=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta):
	if is_enemy==true:
		visible=false
		set_process_unhandled_input(false)
	else:
		if visible:
			set_process_unhandled_input(true)
		elif not visible:
			set_process_unhandled_input(false)
	
func input_event_entered():
	var fight_length = (fight.rect_position - $selector.rect_position).length()
	var pokemon_length = ((pokemon.rect_position - $selector.rect_position).length())
	var bag_length = ((bag.rect_position - $selector.rect_position).length())
	var run_length = ((run.rect_position - $selector.rect_position).length())
	var lengths = [fight_length,pokemon_length,bag_length,run_length]
	for x in range(len(lengths)):
		if lengths.min() == fight_length:
			nearest = "Fight"
		elif lengths.min() == pokemon_length:
			nearest = "Pokemon"
		elif lengths.min() == bag_length:
			nearest = "Bag"
		elif lengths.min() == run_length:
			nearest = "Run"

func _unhandled_input(event: InputEvent) -> void:
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
	elif event.is_action_pressed("ui_accept"):
		input_event_entered()
		print (nearest)
		self.selected = nearest
func set_selected(value):
	selected = value
	emit_signal("selected_by_key",selected)

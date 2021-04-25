extends Node

signal pressed(value)
onready var check1 = get_node("GridContainer/CheckBox")
onready var check2 = get_node("GridContainer/CheckBox2")
onready var check3 = get_node("GridContainer/CheckBox3")
var string setget set_pressed 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check1.pressed = true
	if PlayerData.is_colliding_with == 0 or PlayerData.is_colliding_with == 3 or PlayerData.is_colliding_with == 5:
		check1.text = "Yes"
		check2.text = "No"
		check3.visible = false
	elif PlayerData.is_colliding_with == 1:
		check1.text = PlayerData.player_test["name"] + "'s PC"
		check2.text = "Bill's PC"
		check3.text = "Oak's PC"

func set_pressed(value):
	string = value
	emit_signal("pressed",string)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		if check1.pressed == true:
			check1.pressed = false
			check2.pressed = true
		elif check2.pressed == true:
			check2.pressed = false
			check3.pressed = true
		elif check3.pressed == true:
			check3.pressed = false
			check1.pressed = true
	if event.is_action_pressed("ui_accept"):
		self.string = (which_pressed())

func which_pressed()->String:
	var string_ = ""
	if check1.pressed == true:
		string_= check1.text
	elif check2.pressed == true:
		string_ = check2.text
	elif check3.pressed == true:
		string_ = check3.text
	return (string_)

func _on_CheckBox_pressed() -> void:
	check2.pressed = false
	check3.pressed =false

func _on_CheckBox2_pressed() -> void:
	check1.pressed = false
	check3.pressed =false

func _on_CheckBox3_pressed() -> void:
	check2.pressed = false
	check1.pressed =false
func _process(delta: float) -> void:
	pass

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pokemon1=get_node("Pokemon1")
onready var pokemon2=get_node("Pokemon2")
onready var pokemon3=get_node("Pokemon3")
onready var pokemon4=get_node("Pokemon4")
onready var exit=get_node("exit button")
signal selected_slot(value)
var select_send = 0 setget set_selected_slot
var how_many_pokemon=1+find_maximum()
# Called when the node enters the scene tree for the first time.
func _ready():
	pokemon1.frame=1
	show_boxes()

func find_maximum()->int:
	var maximum = 0
	for x in range(len(PlayerData.player_test["Pokedex"])):
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] == null:
			x=x+1
		if PlayerData.player_test["Pokedex"][x]["Order_in_fight"] >= maximum:
			maximum = PlayerData.player_test["Pokedex"][x]["Order_in_fight"]
	return (maximum)
	
func show_boxes():
	if how_many_pokemon==1:
		$Pokemon2.visible=false
		$Pokemon3.visible=false
		$Pokemon4.visible=false
		$"Progress bar2".visible=false
		$"Progress bar3".visible=false
		$"Progress bar4".visible=false
		$Names.visible=false
		$levels.visible=false
		$hp_total.visible=false
	elif how_many_pokemon==2:
		$Pokemon3.visible=false
		$Pokemon4.visible=false
		$"Progress bar3".visible=false
		$"Progress bar4".visible=false
		$Names/third.visible=false
		$Names/fourth.visible=false
		$levels/Label2.visible=false
		$levels/Label3.visible=false
		$hp_total/Label2.visible=false
		$hp_total/Label3.visible=false
	elif how_many_pokemon==3:
		$Pokemon4.visible=false
		$"Progress bar4".visible=false
		$Names/fourth.visible=false
		$levels/Label3.visible=false
		$hp_total/Label3.visible=false
	elif how_many_pokemon==4:
		pass
		
		
	
	
	
func set_selected_slot(value):
	select_send=value
	emit_signal("selected_slot",select_send)
	
func selected_pokemon()->Array:
	var selected=null
	var object = null
	var next=null
	var prev=null
	var right=null
	var left=null
	if pokemon1.frame==1:
		selected=1
		object=pokemon1
		if how_many_pokemon==4:
			next=pokemon2
			prev=pokemon4
			right=pokemon2
			left=exit
		elif how_many_pokemon==3:
			next=pokemon2
			prev=pokemon3
			right=pokemon2
			left=exit
		elif how_many_pokemon==2:
			next=pokemon2
			prev=pokemon2
			right=pokemon2
			left=exit
		elif how_many_pokemon==1:
			next=exit
			prev=exit
			right=exit
			left=exit
	elif pokemon2.frame==1:
		selected=2
		if how_many_pokemon==4:
			object=pokemon2
			next=pokemon3
			prev=pokemon1
			right=next
			left=prev
		elif how_many_pokemon==3:
			object=pokemon2
			next=pokemon3
			prev=pokemon1
			right=next
			left=prev
		elif how_many_pokemon==2:
			object=pokemon2
			next=exit
			prev=pokemon1
			right=next
			left=prev
	elif pokemon3.frame==1:
		selected=3
		if how_many_pokemon==4:
			object=pokemon3
			next=pokemon4
			prev=pokemon2
			right=next
			left=prev
		elif how_many_pokemon==3:
			object=pokemon3
			next=exit
			prev=pokemon2
			right=next
			left=prev
	elif pokemon4.frame==1:
		selected=4
		if how_many_pokemon==4:
			object=pokemon4
			next=pokemon1
			prev=pokemon3
			right=exit
			left=prev
	elif exit.frame==1:
		selected=5
		object=exit
		next=pokemon1
		right=pokemon1
		left=pokemon1
		if how_many_pokemon==4:
			prev=pokemon4
		elif how_many_pokemon==3:
			prev=pokemon3
		elif how_many_pokemon==2:
			prev=pokemon2
		elif how_many_pokemon==1:
			prev=pokemon1
	var output = [selected,object,next,prev,right,left]
	return (output)



func change_sprite(dir):
	var array = selected_pokemon()
	var object = array[1]
	var selected=array[0]
	var next = array[2]
	var prev = array[3]
	var right=array[4]
	var left=array[5]
	print (array)
	if dir=="down":
		object.frame=0
		next.frame=1
	elif dir=="up":
		print (object)
		object.frame=0
		prev.frame=1
	elif dir=="right":
		object.frame=0
		right.frame=1
	elif dir=="left":
		object.frame=0
		left.frame=1
		
func handle_enter():
	var array = selected_pokemon()
	var selected=array[0]
	$Label.text = String(selected)
	self.select_send = selected
	
func _unhandled_input(event):
	if event.is_action_pressed("down"):
		change_sprite("down")
	elif event.is_action_pressed("up"):
		change_sprite("up")
	elif event.is_action_pressed("right"):
		change_sprite("right")
	elif event.is_action_pressed("left"):
		change_sprite("left")
	elif event.is_action_pressed("ui_accept"):
		handle_enter()



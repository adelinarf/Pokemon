extends Node2D

var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon"]
var number = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	print ($Dialog_/GridContainer/Label.text)
	
func change_dialog():
	$Dialog_/GridContainer/Label.text = dialog[number]
				
# HACER QUE CADA VEZ QUE ENTRE APAREZCA JEJE
func _on_Character_change_dialog(value) -> void:
	if $Character.collide == true:
		$Dialog_.visible = true
	if value == len(dialog):
		$Dialog_.visible = false
		if $Character.number_of_character == 0:
			pokemon_center_heal()
	else:
		$Dialog_/GridContainer/Label.text = dialog[value]

func _on_Character_show_dialog(value) -> void:
	$Dialog_.visible = value

func pokemon_center_heal():
	$Healing.visible = true
	
var selected = null
func _on_CheckBox_pressed() -> void:
	if $Healing/CheckBox.pressed == true:
		$Healing/CheckBox2.pressed = false
	selected = "yes"

func _on_CheckBox2_pressed() -> void:
	if $Healing/CheckBox2.pressed == true:
		$Healing/CheckBox.pressed = false
	selected = "no"

func _on_Button_pressed() -> void:
	if selected == "no":
		$Healing.visible = false
		$Dialog_.visible = true
		$Dialog_/GridContainer/Label.text = "Be right back when you need it"
	elif selected == "yes":
		$Healing.visible = false
		$Dialog_.visible = true
		$Dialog_/GridContainer/Label.text = "We're healing your pokemon"
		PlayerData.heal_pokemon() #Heals every pokemon 
		$Dialog_/GridContainer/Label.text = "We're done with your pokemon be right back when you need it"
			
func _on_Dialog__button_changed(new_value) -> void:
	if new_value == true:
		$Dialog_.visible = false

var dialog1 = ["You turned on the PC","Which PC do you wanna access?"]

func _on_Character2_change_dialog(value) -> void:
	if $Character2.collide == true:
		$Dialog_.visible = true
	if value == len(dialog1):
		$Dialog_.visible = false
		if $Character2.number_of_character == 1:
			access_pc()
	else:
		$Dialog_/GridContainer/Label.text = dialog1[value]

func access_pc():
	pass

func _on_Character2_show_dialog(value) -> void:
	$Dialog_.visible = value

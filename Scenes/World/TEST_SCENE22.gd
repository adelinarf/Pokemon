extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
onready var dialogo = get_node("ConfirmationDialog")
var dialog_number = null
func _on_Character_change_dialog(value) -> void:
	print (value)
	if $Character.collide == true:
		dialogo.popup()
		dialogo.dialog_text = value
var lists = 2#len($Character.dialog)
onready var character = get_node("Character")
var number_of_character = 0
func _on_Character_change_number(value) -> void:
	dialog_number= value
	if value >= lists:
		if number_of_character == 0:  #Pokemon center
			dialogo.dialog_text = "Do you wanna heal your pokemon?"
			dialogo.add_button("Yes",false,"Heal")
			dialogo.add_button("No",false,"Not heal")
		elif number_of_character == 1:  #PC
			pass
		elif number_of_character == 2:  #Trainers
			pass
		elif number_of_character == 3:  #People that give you things
			pass
		else:
			pass

func _on_ConfirmationDialog_confirmed() -> void:
	if dialog_number >= lists and number_of_character == 0:
		dialogo.dialog_text = "We're healing your pokemon"
		PlayerData.heal_pokemon()
		dialogo.dialog_text = "Be back when you need us"

func _on_ConfirmationDialog_custom_action(action: String) -> void:
	if action == "Heal":
		dialogo.get_close_button()
		dialogo.dialog_text = "We're healing your pokemon"
		PlayerData.heal_pokemon()
		dialogo.dialog_text = "Be back when you need us"
	elif action == "Not heal":
		dialogo.dialog_text = "Be back when you need us"
		
		

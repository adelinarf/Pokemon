extends Control

onready var name_player = get_node("Name")
onready var id = get_node("ID")
onready var money = get_node("GridContainer/money")
onready var pokedex = get_node("GridContainer/pokedex")
onready var time = get_node("GridContainer/time")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerData.player_test["Sprite"] == 0:
		$background.frame = 1
	elif PlayerData.player_test["Sprite"] == 1:
		$background.frame = 0
	name_player.text = name_player.text % PlayerData.player_test["name"]
	id.text = id.text % "I HAVENT DONE THIS"
	money.text = money.text % String(PlayerData.player_test["Money"])
	pokedex.text = pokedex.text % String(len(PlayerData.player_test["Pokedex"]))
	time.text = time.text % "Haven't measure that yet"


func _on_Button_pressed() -> void:
	get_tree().change_scene(PlayerData.is_in[1])
	pass # GO BACK TO THE PAUSED SCREEN

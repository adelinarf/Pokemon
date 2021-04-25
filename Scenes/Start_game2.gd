extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialogue_beggining.part=2
	PlayerData.is_in[0] = "beggining"
	PlayerData.colliding_character = "2"
	$character.frame=7+PlayerData.player_test["Sprite"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

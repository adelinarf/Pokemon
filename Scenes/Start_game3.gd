extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialogue_beggining.part=3
	PlayerData.is_in[0] = "beggining"
	PlayerData.colliding_character = "3"
	$character.frame=2
	PlayerData.player_test["id"]=PlayerData.player_id()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D


var route10 = load("res://Scenes/World/Routes/Route 10.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route10
	PlayerData.is_in[0] = "Route10"
	PlayerData.is_in[1] = "res://Scenes/World/Routes/Rock tunnel.tscn"
	PlayerData.colliding_character="Trainer 1"
	$Entrance.next_scene = route10
	$Exit.next_scene = route10

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Exit_area_entered(area):
	PlayerData.is_in[2]=Vector2(462.775,2040.968)


func _on_Entrance_area_entered(area):
	PlayerData.is_in[2]=Vector2(333.921,803.366)

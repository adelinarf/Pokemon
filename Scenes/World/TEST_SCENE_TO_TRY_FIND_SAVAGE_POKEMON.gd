extends Node2D


onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_player_body_entered(body: Node) -> void:
	if body.name == "TileMap":
		timer.set_wait_time(5) 
		timer.start()
		print ("IS INSIDE THE TILE MAP")

func _on_Timer_timeout() -> void:
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining.tscn")

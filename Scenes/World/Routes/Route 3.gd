extends Node2D

var pewter_city = load("res://Scenes/World/Pewter City.tscn")
var route4 = preload("res://Scenes/World/Routes/Route 4.tscn")
func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.route3
	PlayerData.is_in[0]="Route3"
	PlayerData.show_right_dialogue($trainer1)
	PlayerData.show_right_dialogue($trainer2)
	PlayerData.show_right_dialogue($trainer3)
	PlayerData.show_right_dialogue($trainer4)
	PlayerData.show_right_dialogue($trainer5)
	PlayerData.show_right_dialogue($trainer6)
	PlayerData.show_right_dialogue($trainer7)
	PlayerData.show_right_dialogue($trainer8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_player_body_entered(body: Node) -> void:
	if body.name == "Savage pokemon tiles":
		$Timer.set_wait_time(5) 
		$Timer.start()

func _on_player_body_exited(body):
	$Timer.stop()

func _on_Timer_timeout():
	PlayerData.is_colliding_with = 100
	get_tree().change_scene("res://Scenes/Battle_beggining_.tscn")

func _on_to_pewter_city_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(pewter_city)


func _on_to_route4_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene_to(route4)

extends Node2D

var prev = load("res://Scenes/World/Saffron City/Silph Co P5.tscn")
var next = preload("res://Scenes/World/Saffron City/Silph Co P7.tscn")


func _ready():
	PlayerData.current_dialogue = PlayerData.dialogue.saffron_city
	PlayerData.is_in[0] = "SaffronCity"
	PlayerData.is_in[1] = "res://Scenes/World/Saffron City/Silph Co P6.tscn"
	PlayerData.show_right_dialogue($"Trainer 1")
	PlayerData.show_right_dialogue($"Trainer 2")
	PlayerData.show_right_dialogue($"Trainer 3")
	PlayerData.show_right_dialogue($"Trainer 4")
	PlayerData.show_right_dialogue($Rival)
	$downstairs.next_scene = prev 
	$upstairs.next_scene = next
	var fighted = rival_has_fighted()
	if fighted==true:
		$Rival.free()
	elif fighted==false:
		pass

func rival_has_fighted()->bool:
	var dialogue = PlayerData.dialogue
	var pos =null
	for x in range(len(PlayerData.current_dialogue)):
		if PlayerData.current_dialogue[x]["name"]=="Rival_Fight after":
			pos=x
	return (dialogue.saffron_city[pos]["Already_talk"])

func _on_player_colliding(value):
	if PlayerData.colliding_character=="Rival_Fight after":
		var dialogue = PlayerData.dialogue
		var pos =null
		for x in range(len(PlayerData.current_dialogue)):
			if PlayerData.current_dialogue[x]["name"]=="Rival_Fight after":
				pos=x
		dialogue.saffron_city[pos]["Already_talk"]=true
		ResourceSaver.save("res://dialogues/dialogues.tres",PlayerData.dialogue)
		PlayerData.colliding_character="1"

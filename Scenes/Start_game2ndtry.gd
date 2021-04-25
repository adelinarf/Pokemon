extends Control
var part = 1
func _ready() -> void:
	PlayerData.current_dialogue = PlayerData.dialogue.beggining
	PlayerData.is_in[0] = "beggining"
	PlayerData.colliding_character = "1"
	
func _on_Dialogue_beggining_selected(value):
	$background.frame=value
	if value==0:
		$character.frame = 7
	elif value==1:
		$character.frame = 8 
	PlayerData.player_test["Sprite"] = value
			
func _on_Dialogue_beggining_animate(value):
	if value==true:
		$characters.animation = "Nidoran"
		$characters.visible = true

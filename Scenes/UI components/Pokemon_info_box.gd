extends VBoxContainer

export(String, FILE) var next_scene_path:= ""

func _ready() -> void:
	_on_select_pokemon_button_up()
	

func _on_moreinfo_pressed() -> void:
	get_tree().change_scene(next_scene_path)

func _on_select_pokemon_button_up() -> bool:
	var boolean = null
	if $HBoxContainer/select_pokemon.pressed == true:
		boolean = true
	else:
		boolean = false
	print (boolean)
	return (boolean)

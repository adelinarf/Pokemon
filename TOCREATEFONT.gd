extends Label

#add_char(character: int, texture: int, rect: Rect2, align: 
#	Vector2 = Vector2( 0, 0 ), advance: float = -1)

#Adds a character to the font, where character is the Unicode value, 
#texture is the texture index, rect is the region in the texture
 #(in pixels!), align is the (optional) alignment for the character
 #and advance is the (optional) advanc
var font
onready	var texture = load("res://assets/pokemon_battle/battle_beggining/letters.tres")

func _ready():
	# Create font
	font = BitmapFont.new()
	font.add_texture(texture)
	
	var pos = Vector2(0,0)
	var size = Vector2(6.8, 13)
	
	# A-Z
	var chara = 65
	for x in range(0, 26):
		pos.x = x * size.x
		pos.y = 0
		font.add_char(chara, 0, Rect2(pos, size))
		chara = chara + 1

	add_font_override("font", font) # "font" name is magic
	font.update_changes()

	set_uppercase(true)
	ResourceSaver.save("res://font1.tres",font)

# Called when the node enters the scene tree for the first time.
func other() -> void:
	var font = BitmapFont.new() 
	var texture = load("res://assets/pokemon_battle/battle_beggining/letters.tres")
	font.add_texture(texture) 
	font.set_height(13) 
	font.add_char(KEY_A,11,Rect2(Vector2( 1, 1),Vector2()))
	
	ResourceSaver.save("res://font1.tres",font)

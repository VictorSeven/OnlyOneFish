extends TextureRect

var ScManager = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	ScManager = get_node("/root/SceneManager")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	ScManager.goto_scene("res://scenes/credits.tscn")
	pass # Replace with function body.

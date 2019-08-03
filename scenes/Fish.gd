extends Area2D

export var speed = 30.0
var direction = Vector2(0.0, 0.0)
var time = 0.0

# Fishes properties
export var min_speed = 30.0
export var speed_range = 30.0
export var is_the_fish = false
export var acceleration = 30.0
var fish_length=100

onready var fish= load("res://assets/scenes/prefabs/characters/FishSword.tscn")

# Sets speed of the fish
func setspeed():
	var randomnumber = randf()
	speed = min_speed + randomnumber*speed_range
	pass
	
# Sets the direction in which the fish is moving
func setdirection():
	if(self.position.x < 0):
		direction = Vector2(1.0, 0.0)
		scale=Vector2(1,1)
	else:
		direction = Vector2(-1.0, 0.0)
		scale=Vector2(-1,1)
	pass
	
# Checks if the fish you have is The Fish
func is_this_fish_the_fish():
	return is_the_fish

# Initialize fish properties
func init(fish_type):
	var cols=$Sprite.vframes
	
	if cols ==0:
		cols=1
	
	match fish_type:
		"Cualquiera":
			min_speed = 30.0
			speed_range = 30.0
			acceleration = 20.0
			is_the_fish = false
			fish_length = $Sprite.texture.get_size().x / cols
			# FIXME It is necessary to adjust the collision shape size
			# FIXME It is necessary to change the sprite to the type of fish
			# FIXME Here we distinguish the different types of fishes on an if/else
##		"SwordFish":
##			#this doesn't seem to work...
##			fish= load("res://assets/scenes/prefabs/characters/FishSword.tscn")
##			self=fish.instance()

	setspeed()
	setdirection()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	# Make fish move
	self.position += (speed+sin(time)*acceleration)*direction*delta 
	
	# Make fishes come back to the screen
	if (self.position.x <= -(fish_length+OS.get_window_size().x/2)):

		switch_direction()
	elif (self.position.x >= OS.get_window_size().x/2+fish_length): 
		switch_direction()
	pass


func switch_direction():
	direction=-direction
	# we can flip the node, so as the collider also changes its position, by scaling negative:
	scale=Vector2(direction.x,1)

# When our fish gets out of the screen, it dies...
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

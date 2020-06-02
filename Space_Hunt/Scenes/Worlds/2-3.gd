extends Node2D
var flynow = true
export (float) var bullet_delay = 1
var waited = 0
const FLY = preload("res://Scenes/Objects/PlatformeFly.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func go():
	var flyJump = FLY.instance()
	if sign($Fly_Spawn.position.x) == 1:
		flyJump.fly(1)
	else:
		flyJump.fly(-1)
	get_parent().add_child(flyJump)
	flyJump.position = $Fly_Spawn.global_position

func _process(delta):
	if (flynow && waited > bullet_delay): 
		go()
		waited = 0
	elif (waited <= bullet_delay):
		waited += delta
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Ressources/Musics/Scene2.ogg")
	player.play()
	set_process(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

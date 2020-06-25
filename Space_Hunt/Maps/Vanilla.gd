extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Ressources/Sounds/Teleporter.ogg")
	player.play()
	var player2 = AudioStreamPlayer.new()
	self.add_child(player2)
	player2.stream = load("res://Ressources/Musics/Intro_Robot.ogg")
	player2.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

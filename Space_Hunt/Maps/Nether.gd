extends Node2D

onready var dialog = get_node("Polygon2D/Boss Fire says")
onready var zone = get_node("Polygon2D")
onready var p = get_node("Player")

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
	player2.stream = load("res://Ressources/Musics/Scene1.ogg")
	player2.play()
	zone.set_color(Color(0, 0, 0, 0.5))
	p.can_move = false	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialog.done == true:
		zone.set_color(Color(0, 0, 0, 0))
		dialog.set_visible_characters(0)
		p.can_move = true

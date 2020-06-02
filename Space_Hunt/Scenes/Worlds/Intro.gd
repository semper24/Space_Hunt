extends Node2D

onready var player = get_node("Player")
onready var enemy = get_node("Enemy")
const GRAVITY = 10
var velocity = Vector2()
var speed = 200
onready var dialog2 = get_node("Polygon2D/IntroText2")
onready var zone = get_node("Polygon2D")
var is_ready = false

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Ressources/Musics/Intro_Robot.ogg")
	player.play()

func _physics_process(delta):
	if dialog2.done == true && is_ready == false:
		zone.set_color(Color(0, 0, 0, 0))
		is_ready = true
	if is_ready == true:
		if enemy.position.x > player.position.x:
			enemy.manageRun(-1)
		if enemy.position.x < player.position.x:
			enemy.manageRun(1)


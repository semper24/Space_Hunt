extends Node2D

const IDLE_DURATION = 1.0

export var move_to = Vector2.RIGHT * 192
export var speed = 50.0

var follow = Vector2.ZERO

onready var platform = $Platform
onready var tween = $Move_Tween

func _ready():
	_init_tween()

func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)

func _init_tween():
	var duration = move_to.length() / speed 
	tween.interpolate_property(platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION)
	tween.start()

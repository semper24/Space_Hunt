extends Area2D

var _gravity = 0
const SPEED = 200
export (int ) var _direction = 1
var _movement = Vector2()
export (float) var bullet_angle = 350 setget set_bullet_angle
var directional_force = Vector2()
export (int) var bullet_speed = 8

func fly(direction):
	_movement = directional_force
	_direction = direction
	if direction == -1:
		$AnimatedSprite.flip_h = true
	
	#_set_fixed_process(true)

func set_bullet_angle(value):
	bullet_angle = clamp(value, 0, 360)

func update_directional_force():
	directional_force = Vector2(cos(bullet_angle*(PI/180)), sin(bullet_angle*(PI/180))) * bullet_speed 
	
func _ready():
	update_directional_force()
	#set_process_input(true)
	set_process(true)
	pass


func _set_fixed_process(delta):
	update_directional_force()
	_movement.y +=delta * _gravity 
	translate(_movement)


func _physics_process(delta):
	_movement.y = _gravity *delta 
	_movement.x = SPEED * delta * _direction
	$AnimatedSprite.play("Idle")
	translate(_movement)
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

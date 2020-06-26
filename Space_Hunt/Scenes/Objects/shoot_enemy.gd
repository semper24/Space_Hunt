extends Area2D

var _gravity = 0
const SPEED = 200
var _direction = 1
var _movement = Vector2()

func shoot(directional_force, gravity, direction):
	_movement = directional_force
	_gravity = gravity
	_direction = direction
	if direction == -1:
		$AnimatedSprite.flip_h = false
	
	#_set_fixed_process(true)

func _set_fixed_process(delta):
	_movement.y += delta * _gravity
	translate(_movement)


func _physics_process(delta):
	_movement.y = delta * _gravity
	_movement.x = SPEED * delta * _direction
	$AnimatedSprite.play("fire2")
	translate(_movement)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("die")
	if "Player" in body.name:
		body.damage(10)
	queue_free()

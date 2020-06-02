extends KinematicBody2D

const THROW_VELOCITY = Vector2(800, -400)

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += Gobals * delta
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		

extends Area2D

const SPEED = 150
var dir = Vector2()
export(int) var hp = 1
var attack = 5

func _physics_process(delta):
	$AnimatedSprite.play("fire")
	translate(dir * SPEED * delta)

func _flip_sprite(value):
	if value > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

func _setAttack(value):
	attack = value

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.damage(attack)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

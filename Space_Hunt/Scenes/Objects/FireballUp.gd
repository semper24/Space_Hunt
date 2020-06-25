extends Area2D
const SPEED = 400
var velocity = Vector2()
var direction = 1

func _ready():

	pass 

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("fire")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("die")
	if "IceWalker" in body.name:
		body.dead(3)
	if "Alien" in body.name:
		body.dead(3)
	if "drakeIce" in body.name:
		body.dead(3)
	if "MonsterBall" in body.name:
		body.dead(3)
	if "BossMageFirst" in body.name:
		body.dead(3)
	if "BossMageRes" in body.name:
		body.dead(3)
	if "bossFire" in body.name:
		body.dead(3)
	if "GhostFire" in body.name:
		body.dead(3)
	if "IceGhost" in body.name:
		body.dead(3)
	queue_free()

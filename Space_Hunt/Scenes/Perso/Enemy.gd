extends KinematicBody2D

const GRAVITY = 10
const SPEED = 200
const FLOOR = Vector2(0, -1)
var on_wall = false

var velocity = Vector2()

func _ready():
	pass

func manageRun(direction):      
	velocity.x = SPEED * direction                                                       #RUN FUNCTION
	if direction == 1:
		$AnimatedSprite.flip_h = false
	elif direction == -1:
		$AnimatedSprite.flip_h = true

	$AnimatedSprite.play("walk")
	velocity = move_and_slide(velocity, FLOOR)
		

func _physics_process(delta):
	velocity.y += GRAVITY
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_tree().change_scene("res://Scenes/Pages/BridgeScene1.tscn")

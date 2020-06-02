extends KinematicBody2D

const UP = Vector2(0, -1)
const MAX_SPEED = 500
const ACCELERATION = 25
const GRAVITY = 10
const JUMP = -200
var total_jumps = 0
var Jumps = 1#(+1)
var motion = Vector2()
var jumping = false
var player = AudioStreamPlayer.new()

func _ready():
	self.add_child(player)
	player.stream = load("res://Ressources/Sounds/Jump.ogg")

func manageRun():                                                               #RUN FUNCTION
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		$Sprite.play("Run")
		$ParticleMove.emitting = true
		$ParticleMove.scale.x = -1
		$ParticleMove.position.x = -2.5
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED);
		jumping = false
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = false
		$Sprite.play("Run")
		$ParticleMove.emitting = true
		$ParticleMove.scale.x = 1
		$ParticleMove.position.x = 2.5
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED);
		jumping = false
	else:
		$Sprite.play("Idle")
		$ParticleMove.emitting = false
		motion.x = lerp(motion.x, 0, 0.2)
		jumping = false
	pass                                                                        #~RUN FUNCTION

func manageJump():                                                              #JUMP FUNCTION
	if is_on_floor():
		Jumps = 1
		if Input.is_action_just_pressed("ui_up"):
			if total_jumps < 3:
				if jumping == false:
					player.play()
					jumping = true
				$ParticleMove.emitting = true
				motion.y = JUMP
			total_jumps += 1
	else:
		if motion.y > 0:
			$Sprite.play("Fall")
		else:
			$Sprite.play("Jump")
			player.stop()
		motion.x = lerp(motion.x, 0, 0.05)
		if Input.is_action_just_pressed("ui_up"):
			if total_jumps < 3:
				if Jumps != 0:
					motion.y = JUMP
					Jumps -= 1
					
func _physics_process(delta):                                                   #MAIN FUNCTION
	motion.y += GRAVITY

	manageRun()                                                                 #RUN CALL
	manageJump()                                                                #JUMP CALL

	motion = move_and_slide(motion, UP)
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Enemy" in get_slide_collision(i).collider.name:
				get_tree().change_scene("res://Scenes/Pages/BridgeScene1.tscn")


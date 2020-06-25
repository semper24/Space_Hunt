extends KinematicBody2D
#GRAVITY
const UP = Vector2(0, -1)
const GRAVITY = 20
#RUN
var max_speed = 400
const ACCELERATION = 50
#JUMP
var JUMP = -470
var Jumps = 1#(+1)
#MOVE
var motion = Vector2()
#HP
export(int) var hp = 3
var is_dead = false
#SHOOT
const SHOOT = "ui_focus_next"
var stack = 0
const MAXSTACK = 20
var buffer = ""
const FIREBALL = preload("res://Scenes/Objects/shoot.tscn")
const FIREBALLUP = preload("res://Scenes/Objects/FireballUp.tscn")
const BOOM = preload("res://Scenes/Objects/AnimeCac.tscn")
var fireball_power = 1
var speed_up = 0
var Dead = "Dead"
var Run = "Run"
var Idle = "Idle"
var Jump = "Jump"
var Fall = "Fall"
var Die = "Die"
var Idle_and_Shoot = "Idle and Shoot"
var Run_and_Shoot = "Run and Shoot"
var Jump_and_Shoot = "Jump and Shoot"
var Up = false
var fireball = null
var rageBar_on = false
var healBar_on = false
var posTarget = null
var boom = null
var targetUp = Vector2(-13, 0)

func manageShoot():
	if fireball_power == 1:
		fireball = FIREBALL.instance()
	elif fireball_power == 2:
		fireball = FIREBALLUP.instance()
	if sign(posTarget.position.x) == 1:
		fireball.set_fireball_direction(1)
	else:
		fireball.set_fireball_direction(-1)
	get_parent().add_child(fireball)
	fireball.position = posTarget.global_position
	pass

func _rage_bar_vis():
	if rageBar_on == true:
		$Control.show()
	else:
		$Control.hide()

func _heal_bar_vis():
	if healBar_on == true:
		$HealBar.show()
	else:
		$HealBar.hide()

func _check_rage():
	if $Control._rage_max() == true:
		rageBar_on = false
		Player_power_start()

func _set_heal(heal):
	hp = heal

func _on_heal_perso(heal):
	healBar_on = true
	$HealBar/activeHeal.start()
	hp = $HealBar._on_heal_Plus(heal)

func manageRun():#RUN
	_rage_bar_vis()
	_heal_bar_vis()
	if Up == true:
		return
	if is_dead == true:
		$Sprite.play(Dead)
		pass
	if Input.is_action_just_pressed(SHOOT) && Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		if sign(posTarget.position.x) == -1:
			posTarget.position.x *= -1
			$Sprite/Cac/hitboxCac.position.x *= -1
			$Sprite/Cac/PositionArm.position.x *= -1
		stack = MAXSTACK
		buffer = Run_and_Shoot
		manageShoot()
		motion.x = min(motion.x + ACCELERATION, max_speed);
	elif Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		if sign(posTarget.position.x) == -1:
			posTarget.position.x *= -1
			$Sprite/Cac/hitboxCac.position.x *= -1
			$Sprite/Cac/PositionArm.position.x *= -1
		$Sprite.play(Run)
		motion.x = min(motion.x + ACCELERATION, max_speed);
		$ParticleMove.emitting = true
		$ParticleMove.scale.x = -1
		$ParticleMove.position.x = -2.5
	elif Input.is_action_just_pressed(SHOOT) && Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = false
		if sign(posTarget.position.x) == 1:
			posTarget.position.x *= -1
			$Sprite/Cac/hitboxCac.position.x *= -1
			$Sprite/Cac/PositionArm.position.x *= -1
		stack = MAXSTACK
		buffer = Run_and_Shoot
		manageShoot()
		motion.x = max(motion.x - ACCELERATION, -max_speed);
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = false
		if sign(posTarget.position.x) == 1:
			posTarget.position.x *= -1
			$Sprite/Cac/hitboxCac.position.x *= -1
			$Sprite/Cac/PositionArm.position.x *= -1
		$Sprite.play(Run)
		motion.x = max(motion.x - ACCELERATION, -max_speed);
		$ParticleMove.emitting = true
		$ParticleMove.scale.x = 1
		$ParticleMove.position.x = 2.5
		motion.x = max(motion.x - ACCELERATION, -max_speed);
	else:
		$Sprite.play(Idle)
		$ParticleMove.emitting = false
		if Input.is_action_just_pressed(SHOOT):
			stack = MAXSTACK
			buffer = Idle_and_Shoot
			manageShoot()
		motion.x = lerp(motion.x, 0, 0.2)
	if (stack != 0):
		$Sprite.play(buffer)
		stack -= 1
	pass

func manageJump():#JUMP
	if Up == true:
		return
	if is_on_floor():
		Jumps = 1
		if Input.is_action_just_pressed("ui_up"):
			var player = AudioStreamPlayer.new()
			self.add_child(player)
			player.stream = load("res://Ressources/Sounds/Jump.ogg")
			player.play()
			motion.y = JUMP
	else:
		if motion.y > 0:
			$Sprite.play(Fall)
		else:
			$Sprite.play(Jump)
			if Input.is_action_just_pressed(SHOOT):
				stack = MAXSTACK
				buffer = Jump_and_Shoot
				manageShoot()
				$ParticleMove.emitting = true
		motion.x = lerp(motion.x, 0, 0.05)
		if Input.is_action_just_pressed("ui_up") && Jumps != 0:
			var player = AudioStreamPlayer.new()
			self.add_child(player)
			player.stream = load("res://Ressources/Sounds/Jump.ogg")
			player.play()
			motion.y = JUMP
			Jumps -= 1
	if (stack > 0):
		$Sprite.play(buffer)
		stack -= 1
	else:
		buffer = ""
	pass

func _rage_upbar(rage, amount):
		rageBar_on = true
		$Control._on_rage_updatted(rage, amount)
		$Control/active.start()

func damage(dmg):#TAKE DMG
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Ressources/Sounds/Hit.ogg")
	player.play()
	hp -= dmg
	healBar_on = true
	$HealBar/activeHeal.start()
	$HealBar._on_heal_updatted(dmg)
	if hp < 1:
		is_dead = true
		motion = Vector2(0, 0)
		$Sprite.play(Die)
		$Timer.start()
		get_tree().change_scene("res://Scenes/Pages/GameOver.tscn")
	else:
		$Sprite.play(Fall)
	pass

func manageCac():
	if is_on_floor():
		if Input.is_key_pressed(KEY_E):
			if Idle == "Idle_Up":
				Up = true
				$Sprite/Cac/cacAnime.start()
				$Sprite/Cac/collisionTimer.start()
				$Sprite.play("cac")

func _physics_process(delta):#MAIN
	posTarget = $Position2D
	if Up == true:
		return
	motion.y += GRAVITY
	manageRun()
	manageCac()
	manageJump()
	motion = move_and_slide(motion, UP)
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Alien" in get_slide_collision(i).collider.name:
				damage(1)
			if "MonsterBall" in get_slide_collision(i).collider.name:
				damage(5)
			if "IceWalker" in get_slide_collision(i).collider.name:
				damage(5)
			if "BossMageRes" in get_slide_collision(i).collider.name:
				damage(100)
			if "BossMageFirst" in get_slide_collision(i).collider.name:
				damage(100)
			if "bossFire" in get_slide_collision(i).collider.name:
				damage(100)
	var position = get_position()
	if (position.y > 10000):
		get_tree().change_scene("res://Scenes/Pages/GameOver.tscn")
	pass

func _on_Timer_timeout():#CHANGE SCENE AFTER DEATH
	get_tree().change_scene("res://Scenes/Worlds/1-1.tscn")

func Fire_power_up():
	fireball_power = 2

func Player_power_start():
	Up = true
	$Sprite.play("Spawn0")
	$SpawnTimeOne.start()

func Player_power_down():
	Up = true
	$Position2D.position = Vector2(-44.936, 0.142)
	posTarget = $Position2D
	$Sprite.play("PowerDown2")
	$TimerDown.start()
	JUMP = -470
	Dead = "Dead"
	Run = "Run"
	Idle = "Idle"
	Jump = "Jump"
	Fall = "Fall"
	Die = "Die"
	Idle_and_Shoot = "Idle and Shoot"
	Run_and_Shoot = "Run and Shoot"
	Jump_and_Shoot = "Jump and Shoot"

func Player_power_up():
	#while is_on_floor() != true:
	#	motion.y += GRAVITY
	#	motion = move_and_slide(motion, UP)
	scale = Vector2(3.5, 3.5)
	$Position2D.position = Vector2(-15,0)
	posTarget = $Position2D
	$HitboxUp.set_deferred("disabled", false)
	$Hitbox.set_deferred("disabled", true)
	$Sprite.play("Spawn")
	$SpawnTime.start()
	JUMP = -600
	Dead = "Dead"
	Run = "Run_Up"
	Idle = "Idle_Up"
	Jump = "Jump Up"
	Fall = "Fall Up"
	Die = "Die Up"
	Idle_and_Shoot = "Idle and Shoot Up"
	Run_and_Shoot = "Run and Shoot Up"
	Jump_and_Shoot = "Idle and Shoot Up"
	$TimerDownNow.start()

func speed_change(new, new_speed):
	speed_up = new
	max_speed = max_speed * new_speed
	$Ghost_end.start() 

func _on_Ghost_Timer_timeout():
	if speed_up == 2:
		var this_ghost = preload("res://Scenes/Objects/Ghost.tscn").instance()
		get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.scale = Vector2(0.2, 0.2)
		this_ghost.texture = $Sprite.frames.get_frame($Sprite.animation, $Sprite.frame)
		this_ghost.flip_h = $Sprite.flip_h

func _on_Ghost_end_timeout():
	max_speed = 400
	speed_up = 0

func _on_SpawnTime_timeout():
	Up = false
	$Sprite.play("Idle_Up")
	buffer = "Idle_Up"
	#get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)

func _on_SpawnTimeOne_timeout():
	Player_power_up()

func _on_active_timeout():
	rageBar_on = false

func cac_hit():
	boom = BOOM.instance()
	get_parent().add_child(boom)
	boom.play()
	boom.position = $Sprite/Cac/PositionArm.global_position
	pass

func _on_Cac_body_entered(body):
	if "IceWalker" in body.name:
		cac_hit()
		body.dead(5)
	if "Alien" in body.name:
		cac_hit()
		body.dead(5)
	if "drakeIce" in body.name:
		cac_hit()
		body.dead(5)
	if "MonsterBall" in body.name:
		cac_hit()
		body.dead(5)
	if "BossMageRes" in body.name:
		cac_hit()
		body.dead(10)
	if "BossMageFirst" in body.name:
		cac_hit()
		body.dead(10)
	if "bossFire" in body.name:
		cac_hit()
		body.dead(10)
	print(body.name)
	pass # Replace with function body.
	
func _on_cacAnime_timeout():
	Up = false
	$Sprite/Cac/hitboxCac.set_deferred("disabled", false)
	pass # Replace with function body.


func _on_collisionTimer_timeout():
	$Sprite/Cac/hitboxCac.set_deferred("disabled", true)
	pass # Replace with function body.

func _on_TimerDown_timeout():
	scale = Vector2(1.5, 1.5)
	$HitboxUp.set_deferred("disabled", true)
	$Hitbox.set_deferred("disabled", false)
	$Sprite.play("PowerDown")
	$TimerDown2.start()
	pass # Replace with function body.

func _on_TimerDown2_timeout():
	Up = false
	pass # Replace with function body.


func _on_TimerDownNow_timeout():
	Player_power_down()
	$Control._on_rage_updatted(0, 0)
	$Control/active.start()
	pass # Replace with function body.


func _on_activeHeal_timeout():
	healBar_on = false

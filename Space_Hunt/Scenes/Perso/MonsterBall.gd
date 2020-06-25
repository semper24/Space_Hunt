extends KinematicBody2D

export (float) var bullet_angle = 350 setget set_bullet_angle
export (int) var bullet_speed = 8
const GRAVITY = 10
export(int) var speed = 30
const FLOOR = Vector2(0, -1)

export(int) var hp = 25

var velocity = Vector2()

var shooting = true

export (float) var bullet_delay = 1
var waited = 0

var direction = 1

export (int) var bullet_gravity = 5
export (PackedScene) var bullet_scene
export (NodePath) var bullet_spawn_path
onready var bullet_spawn = (bullet_spawn_path)

var take_damage = false

var directional_force = Vector2()

var is_dead = false

func _input(event):
	if (event.is_action_pressed("ui_select")):
		shooting = true
	elif (event.is_action_released("ui_select")):
		shooting = false

func _process(delta):

	if (shooting && waited > bullet_delay): 
		fire_once()
		waited = 0
	elif (waited <= bullet_delay):
		waited += delta

func fire_once():
	shoot()

func _ready():
	if is_dead == false:
		update_directional_force()
		#set_process_input(true)
		set_process(true)
	pass

func dead(damage):
	hp -= damage
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("die2")
		$collision.set_deferred("disabled", true)
		#$Timer.start()
	else:
		take_damage = true
		$AnimatedSprite.play("Hit")
		$Timer2.start()
func set_bullet_angle(value):
	bullet_angle = clamp(value, 0, 360)

func update_directional_force():
	directional_force = Vector2(cos(bullet_angle*(PI/180)), sin(bullet_angle*(PI/180))) * bullet_speed 

func _physics_process(delta):
	if is_dead == false:
		if take_damage == false:
			$AnimatedSprite.play("Idle")
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.damage()

func _on_Timer_timeout():
	queue_free()
	pass 

func shoot():
	#fireball.position = $Position2D.global_position
	if is_dead == false:
		var bullet = bullet_scene.instance()
		bullet.position = $bullet_spawn.global_position
		if sign($bullet_spawn.position.x) == 1:
			bullet.shoot(directional_force, bullet_gravity, 1)
		else:
			bullet.shoot(directional_force, bullet_gravity, -1)
		get_parent().add_child(bullet)
		
	#fireball.set_global_pos()


func _on_Timer2_timeout():
	take_damage = false
	pass # Replace with function body.


func _on_Timer3_timeout():
	if is_dead == false:
		var bullet = bullet_scene.instance()
		bullet.position = $bullet_spawn2.global_position
		if sign($bullet_spawn2.position.x) == 1:
			bullet.shoot(directional_force, bullet_gravity, 1)
		else:
			bullet.shoot(directional_force, bullet_gravity, -1)
		get_parent().add_child(bullet)
	pass # Replace with function body.

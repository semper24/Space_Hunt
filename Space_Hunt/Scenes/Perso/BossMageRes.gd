extends KinematicBody2D

var player
export (int) var speed = 100
var direction = Vector2()
var angle = 0.0
var is_dead = false
var bullet = preload("res://Scenes/Objects/firebalmageRes.tscn")
export var offset = 25
var status = false
var next = true
var hp = 3

func _ready():
	pass

func start():
	is_dead = true
	$AnimatedSprite.play("spawn")
	$AnimatedSprite.flip_h = true
	$TimerSpawn.start()

func dead(damage):
	hp -= damage
	if hp <= 0:
		is_dead = true
		$CollisionPolygon2D.set_deferred("disabled", false)
		$AnimatedSprite.play("die")
		$CollisionPolygon2D.set_deferred("disabled", true)
		$Timer.start()

func _physics_process(delta):
	if is_dead == true:
		return
	$AnimatedSprite.play("attack")
	if $AnimatedSprite.frame == 9 && next == true:
		next = false
		_attack()
	if next == false && $AnimatedSprite.frame != 9:
		next = true
	angle += 0.05
	pos_clock(angle)
	if angle > 360.0 : angle = 0.0
	player = get_parent().get_node("Player")
	direction = _get_dir(player)
	var motion = direction * speed * delta
	position += motion
	if direction.x > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	if status != $AnimatedSprite.flip_h:
		status = $AnimatedSprite.flip_h
		$Position2D.position.x *= -1
		$CollisionPolygon2D.position.x *= -1


func pos_clock(value):
	$CollisionPolygon2D.position.x = 50 * sin(value)
	$CollisionPolygon2D.position.y = 50 * cos(value)

func _attack():
	if is_dead == false:
		var dir = _get_dir(player)
		var b = bullet.instance()
		get_parent().add_child(b)
		#b.position = position + dir * offset
		b.position = $Position2D.global_position
		b.dir = dir
		b._setAttack(15)
		b._flip_sprite(direction.x)

func _get_dir(target):
	return (target.position - position).normalized()


func _on_Timer_timeout():
	queue_free()
	get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)


func _on_TimerSpawn_timeout():
	is_dead = false

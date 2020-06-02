extends StaticBody2D

var dir = Vector2()
var player
var bullet = preload("res://Scenes/Objects/firebalmage.tscn")
export var offset = 20
export(int) var hp = 50
var is_dead = false
var ressurection = preload("res://Scenes/Perso/BossMageRes.tscn")

func _ready():
	if is_dead == false:
		$AnimatedSprite.play("attack")
		player = get_parent().get_child(1)
		dir = _get_dir(player)
	

func _physics_process(delta):
	dir = _get_dir(player)

func _get_dir(target):
	return (target.position - position).normalized()


func _on_Timer_timeout():
	if is_dead == false:
		dir = _get_dir(player)
		var b = bullet.instance()
		get_parent().add_child(b)
		b.position = position + dir * offset
		b.dir = dir
		b._setAttack(8)


func dead(damage):
	hp -= damage
	if hp <= 0:
		is_dead = true
		$AnimatedSprite.play("up")
		$Timer.start()
		$TimerUp.start()


func _on_TimerUp_timeout():
	var BossMageRes = ressurection.instance()
	get_parent().add_child(BossMageRes)
	BossMageRes.position = $PositionSpawn.global_position
	BossMageRes.start()
	queue_free()

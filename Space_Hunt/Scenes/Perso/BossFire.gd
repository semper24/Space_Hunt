extends StaticBody2D

var is_dead = false
var dir = Vector2()
var player
var FireD1
var Fire1
var FireD2
var Fire2
var bullet = preload("res://Scenes/Objects/fireballBoss.tscn")
var bullet1 = preload("res://Scenes/Objects/fireballBoss2.tscn")
var bullet2 = preload("res://Scenes/Objects/fireballBoss3.tscn")
var potion = preload("res://Scenes/Objects/Potion.tscn")
var block
var noc
export var offset = 20
export(int) var hp = 1

func _ready():
	if is_dead == false:
		$AnimatedSprite.play("attack")
		player = get_parent().get_child(1)
		Fire1 = get_parent().get_child(2)
		FireD1 = get_parent().get_child(3)
		Fire2 = get_parent().get_child(4)
		FireD2 = get_parent().get_child(5)
		block = get_parent().get_child(6)
		noc = get_parent().get_child(7)
		dir = _get_dir(player)

func dead(damage):
	hp -= damage
	if hp <= 0:
		is_dead = true
		var popo = potion.instance()
		get_parent().add_child(popo)
		popo.position = position
		queue_free()
		block.queue_free()
		noc.queue_free()

func _get_dir(target):
	return (target.position - position).normalized()

func _physics_process(delta):
	dir = _get_dir(player)

func _on_TimerFire1_timeout():
	if is_dead == false:
		dir = _get_dir(FireD1)
		var b = bullet.instance()
		get_parent().add_child(b)
		b.position = Fire1.position + dir * offset
		b.dir = -dir + Vector2(0, 20)
		b._setAttack(8)


func _on_TimerFire2_timeout():
	if is_dead == false:
		dir = _get_dir(FireD2)
		var b = bullet1.instance()
		get_parent().add_child(b)
		b.position = Fire2.position + dir * offset
		b.dir = -dir + Vector2(0, 20)
		b._setAttack(8)


func _on_TimerFire3_timeout():
	if is_dead == false:
		dir = _get_dir(player)
		var b = bullet2.instance()
		get_parent().add_child(b)
		b.position = position + dir * offset
		b.dir = dir
		b._setAttack(8)

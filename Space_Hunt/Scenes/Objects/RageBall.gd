extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")
	
func _on_RageBall_body_entered(body):
	if "Player" in body.name:
		$CollisionShape2D.set_deferred("disabled", true)
		body._rage_upbar(50,5)
		body._check_rage()
		$AnimatedSprite.play("Dead")
		$timerDead.start()

func _on_timerDead_timeout():
	queue_free()

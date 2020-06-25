extends Area2D


func _ready():
	$AnimatedSprite.play("Idle")

func _on_HealRegen_body_entered(body):
	if "Player" in body.name:
		$CollisionShape2D.set_deferred("disabled", true)
		body._on_heal_perso(20)
		queue_free()

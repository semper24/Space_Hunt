extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")


func _on_Star1_body_entered(body):
	if "Player" in body.name:
		body.Fire_power_up()

		queue_free()

extends Area2D
var end = false

func _ready():
	$AnimatedSprite.play("Idle")


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.Player_power_start()
		queue_free()

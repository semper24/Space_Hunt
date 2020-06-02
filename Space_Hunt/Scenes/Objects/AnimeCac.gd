extends Area2D


func _ready():

	pass 

func play():
	$AnimatedSprite.play("boom")
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

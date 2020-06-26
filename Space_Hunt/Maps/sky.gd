extends Area2D

func _ready():
	pass 
	

func _on_sky_body_entered(body):
	if "Player" in body.name:
		body.set_slide(0.01)
	pass # Replace with function body.

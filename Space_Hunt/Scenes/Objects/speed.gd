extends Area2D
var already_on = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		if already_on == false:
			body.speed_change(2, 1.8)
			already_on = true
			$Timer.start()


func _on_Timer_timeout():
	already_on = false

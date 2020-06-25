extends Area2D

export (String, FILE, "*.tscn") var World

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			var player = AudioStreamPlayer.new()
			self.add_child(player)
			player.stream = load("res://Ressources/Sounds/Teleporter.ogg")
			player.play()
			get_tree().change_scene(World)
	pass

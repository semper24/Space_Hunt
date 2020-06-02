extends RichTextLabel


func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Ressources/Musics/Bridge_Scene1.ogg")
	player.play()
	pass # Replace with function body.

func _physics_process(delta):
	set_process_input(true)

func _input(event):
	if event is InputEventKey && event.is_pressed():
		if !Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
			get_tree().change_scene("res://Scenes/Worlds/1-1.tscn")

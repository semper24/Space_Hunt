 extends Node

onready var dialog = get_node("Polygon2D/RichTextLabel2")
onready var zone = get_node("Polygon2D")

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Ressources/Musics/Intro_SpaceHunt.ogg")
	player.play()
	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.grab_focus()

func _on_TextureButton_pressed():
	zone.set_color(Color(0, 0, 0, 0.3))
	if dialog.done == true:
		get_tree().change_scene("res://Maps/Vanilla.tscn")

func _on_TextureButton2_pressed():
	get_tree().quit()


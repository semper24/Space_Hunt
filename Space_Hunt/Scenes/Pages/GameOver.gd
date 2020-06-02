extends Node

onready var dialog = get_node("Polygon2D/RichTextLabel2")
onready var zone = get_node("Polygon2D")

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Restart.grab_focus()
	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Restart.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Restart.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Exit.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Exit.grab_focus()

func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/Worlds/1-1.tscn")

func _on_Exit_pressed():
	get_tree().quit()


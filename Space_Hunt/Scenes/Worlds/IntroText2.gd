extends RichTextLabel

var done = false
onready var zone = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	set_process_input(true)
	var col = zone.get_color()
	if col.a == 0:
		set_percent_visible(0)

func _input(event):
	if event is InputEventKey && event.is_pressed():
		done = true

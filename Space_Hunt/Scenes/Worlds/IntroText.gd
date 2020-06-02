extends RichTextLabel

var done = false
onready var zone = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var col = zone.get_color()
	if col.a == 0:
		set_percent_visible(0)

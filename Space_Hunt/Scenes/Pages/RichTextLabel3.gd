extends RichTextLabel


onready var zone = get_parent()

func _ready():
	pass
	
func _physics_process(delta):
	var col = zone.get_color()
	if col.a > 0:
		set_percent_visible(1)

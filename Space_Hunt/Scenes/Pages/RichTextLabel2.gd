extends RichTextLabel

var page = 0
var dialog = ["Welcome to Space Hunt !", "We hope you have pleasant time in our world."]
var done = false
onready var zone2 = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible_characters(0)
	pass

func _physics_process(delta):
	var col = zone2.get_color()
	if col.a > 0:
		set_bbcode(dialog[page])
		set_process_input(true)

func _input(event):
	if event is InputEventKey && event.is_pressed():
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if page == 1 && get_visible_characters() > get_total_character_count():
		done = true

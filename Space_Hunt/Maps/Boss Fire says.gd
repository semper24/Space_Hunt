extends RichTextLabel

var page = 0
var dialog = ["Welcome stranger, I am the almighty king of the lava realm.",
"You've come a long way to here. What do you seek ?", 
"Do you think that by fighting me you will find back what you lost ?",
"It may be solution but let me tell you that I will not give in.",
"I will stop your bloodthirsty run right here and end your pointless life.",
"Lets find out who the king is." ]

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
	if event is InputEventKey and event.scancode == KEY_ENTER:
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if page == 5 && get_visible_characters() > get_total_character_count():
		done = true

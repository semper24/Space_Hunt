extends RichTextLabel

var page = 0
var dialog = ["Who are you and what are you doing in the throne hall ?",
"I don't really care actually.",
"You killed my people but how dare you enter here without a permission ?",
"I'm going to destroy you and all of your race.",
"So that I will never be bothered again. Behold the ice master !"]

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
	if page == 4 && get_visible_characters() > get_total_character_count():
		done = true

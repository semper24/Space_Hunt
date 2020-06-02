extends Control

onready var rage_bar = $RageBarOver
onready var update_tween = $Tween
var rage = 0

func _on_rage_updatted(ragePlus, amount):
	rage += ragePlus
	update_tween.interpolate_property(rage_bar, "value", rage_bar.value, rage, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

func _on_max_rage_updated(max_rage):
	rage_bar.max_value = max_rage

func _rage_max():
	if rage >= 100:
		rage_bar.value = 0
		rage = 0;

		return true
	else:
		return false

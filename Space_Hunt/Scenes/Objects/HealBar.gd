extends Control

onready var health_bar = $HealBarOver
onready var update_tween = $Tween
var rage = 100

func _on_heal_updatted(Damage):
	rage -= Damage
	update_tween.interpolate_property(health_bar, "value", health_bar.value, rage, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

func _on_max_rage_updated(max_rage):
	health_bar.max_value = max_rage

func _rage_max():
	if rage >= 100:
		health_bar.value = 0
		rage = 0;

		return true
	else:
		return false

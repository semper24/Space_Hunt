extends Control

onready var health_bar = $HealBarOver
onready var update_tween = $Tween
var hp = 100
var check

func _on_heal_updatted(Damage):
	hp -= Damage
	update_tween.interpolate_property(health_bar, "value", health_bar.value, hp, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

func _on_heal_Plus(Plus):
	check = hp + Plus
	if check >= 100:
		hp = 100
	else:
		hp += Plus
	update_tween.interpolate_property(health_bar, "value", health_bar.value, hp, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	return hp

func _on_max_rage_updated(max_rage):
	health_bar.max_value = max_rage

func _rage_max():
	if hp >= 100:
		health_bar.value = 0
		hp = 0;

		return true
	else:
		return false

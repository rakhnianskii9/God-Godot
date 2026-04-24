extends Control

onready var subtitle = $Subtitle
onready var accent = $Accent


func _process(_delta):
	var pulse = 1.0 + 0.04 * sin(OS.get_ticks_msec() / 240.0)
	accent.rect_scale = Vector2(pulse, pulse)


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
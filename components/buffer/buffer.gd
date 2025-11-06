extends Node
class_name Buffer

signal end()

@export var duration : float = 0.5
var buffer : bool = false
var timer : float = 0

func _process(delta: float) -> void:
	if timer > 0 : timer -= delta
	if timer < 0 :
		buffer = false
		emit_signal("end")

func start():
	buffer = true
	timer = duration

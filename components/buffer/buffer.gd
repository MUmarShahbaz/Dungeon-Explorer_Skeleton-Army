extends Node
class_name Buffer

var buffer : bool = false
var duration : float = 0.25
var timer : float = 0

func _process(delta: float) -> void:
	if timer > 0 : timer -= delta
	if timer < 0 :
		buffer = false

func start():
	buffer = true
	timer = duration

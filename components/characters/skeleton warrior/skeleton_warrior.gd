extends Enemy

@export var attack_buffer : Buffer

func _process(delta: float) -> void:
	ANM_Animation_Tree.set("parameters/conditions/attack", attack_buffer.buffer)

func attack():
	pass

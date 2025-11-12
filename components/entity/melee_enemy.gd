extends Enemy
class_name MeleeEnemy

@export var attack_buffer : Buffer
@export var melee_controller : MeleeController

func _process(_delta: float) -> void:
	ANM_Animation_Tree.set("parameters/conditions/attack", attack_buffer.buffer)

func pounce(player):
	super.pounce(player)
	attack_buffer.start()

func flip():
	super.flip()
	melee_controller.flip()

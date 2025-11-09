extends Player
class_name Knight

@export var Primary_Move_Buffer : Buffer
@export var melee_controller : MeleeController

var protect : bool = false

func _process(_delta: float) -> void:
	ANM_Animation_Tree.set("parameters/conditions/attack", Primary_Move_Buffer.buffer)
	ANM_Animation_Tree.set("parameters/conditions/protect", protect)
	ANM_Animation_Tree.set("parameters/conditions/not_protect", !protect)

func primary():
	Primary_Move_Buffer.start()

func secondary():
	protect = true
	while Input.is_action_pressed("secondary"):
		await get_tree().physics_frame
	protect = false

func flip():
	super.flip()
	melee_controller.flip()

extends Node
class_name MeleeController

@onready var parent = get_parent() as Entity
@export var Move_List : Array[MeleeAttack]
var attacking = null

func _process(delta: float) -> void:
	if attacking:
		if parent.check_anim(attacking) == false:
			attacking = null
	else:
		for melee_attack : MeleeAttack in Move_List:
			if parent.check_frame(melee_attack.Animation_Name, melee_attack.Animation_Frame):
				attacking = melee_attack.Animation_Name
				(get_node_or_null(melee_attack.Damage_Zone) as DamageZone).damage_all(parent.ATK_Damage)

func flip():
	for melee_attack : MeleeAttack in Move_List:
		(get_node_or_null(melee_attack.Damage_Zone) as DamageZone).flip()

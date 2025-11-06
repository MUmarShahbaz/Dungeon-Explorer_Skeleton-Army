extends Enemy

@export var attack_buffer : Buffer
@export var attack_1 : DamageZone
@export var attack_2 : DamageZone
@export var attack_3 : DamageZone

func _process(delta: float) -> void:
	ANM_Animation_Tree.set("parameters/conditions/attack", attack_buffer.buffer)
	if check_frame("attack_1", 3): attack_1.damage_all(ATK_Damage)
	if check_frame("attack_2", 3): attack_2.damage_all(ATK_Damage)
	if check_frame("attack_3", 2): attack_3.damage_all(ATK_Damage)

func pounce(player):
	super.pounce(player)
	attack_buffer.start()

func flip():
	super.flip()
	attack_1.flip()
	attack_2.flip()
	attack_3.flip()

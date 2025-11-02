extends CharacterBody2D
class_name Entity

@export_group("Health", "HP")
@export var HP_Health_Points : float = 100
@export var HP_Regeneration_Rate : float = 1

@export_group("Stamina", "SP")
@export var SP_Stamina_Points : float = 100
@export var SP_Regeneration_Rate : float = 1

@export_group("Movement", "MV")
@export var MV_Speed : float = 100
@export var MV_Run_Speed : float = 300
@export var MV_Jump : float = -300

@export_group("Attack", "ATK")
@export var ATK_Damage : float = 10
@export var ATK_Primary_Combo_Length : int = 3

var facing : int = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func take_damage(amount):
	HP_Health_Points -= amount

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

@export_group("Animation", "ANM")
@export var ANM_Animated_Sprite : AnimatedSprite2D
@export var ANM_Animation_Player : AnimationPlayer
@export var ANM_Animation_Tree : AnimationTree

var facing : int = 1
@onready var max_hp = HP_Health_Points
@onready var max_sp = SP_Stamina_Points

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if HP_Health_Points < max_hp : HP_Health_Points += HP_Regeneration_Rate * delta
	else: HP_Health_Points = max_hp

func flip():
	facing *= -1
	ANM_Animated_Sprite.flip_h = !ANM_Animated_Sprite.flip_h

func take_damage(amount):
	HP_Health_Points -= amount

func check_anim(animation : String):
	return ANM_Animated_Sprite.animation == animation

func check_frame(animation : String, frame : int):
	return ANM_Animated_Sprite.animation == animation and ANM_Animated_Sprite.frame == frame

func await_frame(animation: String, frame : int):
	while !check_frame(animation, frame):
		await get_tree().physics_frame
	return true

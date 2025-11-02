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

@export_group("Sound Effects", "SFX")
@export var SFX_Walk : AudioStreamPlayer2D
@export var SFX_Run : AudioStreamPlayer2D
@export var SFX_Jump : AudioStreamPlayer2D
@export var SFX_Hurt : AudioStreamPlayer2D
@export var SFX_Die : AudioStreamPlayer2D
@export var SFX_Heal : AudioStreamPlayer2D

var facing : int = 1
@onready var max_hp = HP_Health_Points
@onready var max_sp = SP_Stamina_Points

func _physics_process(delta: float) -> void:
	if HP_Health_Points <= 0:
		velocity = Vector2.ZERO
		ANM_Animation_Tree.get("parameters/playback").travel("die")
		await  get_tree().create_timer(ANM_Animation_Player.get_animation("die").length).timeout
		queue_free()
	if not is_on_floor():
		velocity += get_gravity() * delta
	if HP_Health_Points < max_hp : HP_Health_Points += HP_Regeneration_Rate * delta
	else: HP_Health_Points = max_hp
	if SP_Stamina_Points < max_sp : SP_Stamina_Points += SP_Regeneration_Rate * delta
	else: SP_Stamina_Points = max_sp
	if velocity.x != 0: velocity.x = move_toward(velocity.x, 0, delta*10)

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

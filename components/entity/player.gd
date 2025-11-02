extends Entity
class_name Player

signal cam(direction : Vector2)

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

@export_group("Items", "ITM")
@export var ITM_Healing_Potions : int = 3
@export var ITM_Booster_Potions : int = 5

var direction : int = 1

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))

func _ready() -> void:
	if is_multiplayer_authority():
		var myCAM = CAM.new()
		myCAM.target = self
		add_child.call_deferred(myCAM)
		cam.connect(Callable(myCAM, "set_target_offset"))
		var myEars = AudioListener2D.new()
		add_child.call_deferred(myEars)
		myEars.make_current()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if is_multiplayer_authority(): control(delta)
	move_and_slide()

func control(delta : float):
	camera()
	attack()
	special()
	movement(delta)

func camera():
	var cam_dir = Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down").normalized()
	emit_signal("cam", cam_dir)

var force_pause : bool = false
var pause_on_anims : Array[String] = ["attack_1", "attack_2", "attack_3", "protect", "secondary"]
func pause_movement():
	if force_pause : return true
	for anim in pause_on_anims:
		if check_anim(anim) : return true
	return false
func movement(delta : float):
	if pause_movement(): return
	var x_dir : float = Input.get_axis("left", "right")
	if x_dir != 0:
		if Input.is_action_pressed("sprint"):
			velocity.x = x_dir * MV_Run_Speed
			if is_on_floor(): ANM_Animation_Tree.get("parameters/playback").travel("run")
		else:
			velocity.x = x_dir * MV_Speed
			if is_on_floor(): ANM_Animation_Tree.get("parameters/playback").travel("walk")
	else: velocity.x = 0
	if x_dir * direction < 0 : flip()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += MV_Jump
		ANM_Animation_Tree.get("parameters/playback").travel("jump")

func attack():
	if Input.is_action_just_pressed("primary"):
		primary()
	if Input.is_action_just_pressed("secondary"):
		secondary()

func special():
	if Input.is_action_just_pressed("heal") and ITM_Healing_Potions > 0:
		ITM_Healing_Potions -= 1
		HP_Health_Points += HP_Regeneration_Rate * 60
		SP_Stamina_Points += SP_Regeneration_Rate * 30
	if Input.is_action_just_pressed("boost") and ITM_Booster_Potions > 0:
		ITM_Booster_Potions -= 1
		SP_Stamina_Points += SP_Regeneration_Rate * 60

# Functions to be rewritten in Lowest Child
func flip():
	direction *= -1
	ANM_Animated_Sprite.flip_h = !ANM_Animated_Sprite.flip_h
func primary():
	pass
func secondary():
	pass

# Misc
func check_anim(animation : String):
	return ANM_Animated_Sprite.animation == animation
func check_frame(animation : String, frame : int):
	return ANM_Animated_Sprite.animation == animation and ANM_Animated_Sprite.frame == frame

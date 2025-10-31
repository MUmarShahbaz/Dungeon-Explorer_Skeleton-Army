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
	pass

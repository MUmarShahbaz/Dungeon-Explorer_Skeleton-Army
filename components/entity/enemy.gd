extends Entity
class_name Enemy

func _ready() -> void:
	add_to_group("enemies")
	set_collision_layer_value(1, false)
	set_collision_layer_value(3, true)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	mob_brain(delta)
	move_and_slide()

@export_group("Vision", "VIS")
@export var VIS_Ray : RayCast2D
@export var VIS_Range : float
@export var VIS_Attack_Range : float
@export_group("Other")
@export var spread : float = 60
# Mob Brain
enum  state {patrol, pursue, pounce}
var current_state : state = state.patrol

func mob_brain(delta):
	var player = find_closest_player()
	match current_state:
		state.patrol:
			if player:
				current_state = state.pursue
				return
			patrol(delta)
		state.pursue:
			if not player:
				current_state = state.patrol
				return
			if to_local(player.global_position).length() < VIS_Attack_Range:
				current_state = state.pounce
				return
			pursue(player, delta)
		state.pounce:
			if not player:
				current_state = state.patrol
				return
			if to_local(player.global_position).length() > VIS_Attack_Range:
				current_state = state.pursue
				return
			pounce(player)

# Behaviour
@onready var home = global_position
var distance_from_home = 50
func patrol(delta):
	if !check_anim("idle") and !check_anim("walk"): home = global_position
	print(!check_anim("idle") and !check_anim("walk"))
	if to_local(home).x < distance_from_home and velocity.x == 0:
		if randi_range(0, 1) == 1: flip()
		ANM_Animation_Tree.get("parameters/playback").travel("walk")
		velocity.x = facing * MV_Speed
	if to_local(home).x >= distance_from_home:
		ANM_Animation_Tree.get("parameters/playback").travel("idle")
		velocity.x = 0
		await get_tree().create_timer(randf_range(0.5, 1)).timeout

func pursue(player : Player, delta: float):
	ANM_Animation_Tree.get("parameters/playback").travel("run")
	face_player(player)
	var dir : Vector2 = to_local(player.global_position).normalized()
	velocity.x = dir.x * delta * 100 * MV_Run_Speed

# Rewrite in lowest child
func pounce(player):
	face_player(player)
	velocity.x = 0

# Misc
func find_closest_player():
	var closest_player : Player
	var closest_player_distance : float = INF
	for player : Player in get_tree().get_nodes_in_group("players"):
		var to_player : Vector2 = to_local(player.global_position)
		if to_player.x * facing < 0 and to_player.length() > VIS_Attack_Range: continue
		var ray_target : Vector2 = to_player
		if to_player.length() > VIS_Range:
			ray_target = ray_target.normalized() * VIS_Range
		VIS_Ray.target_position = ray_target
		VIS_Ray.force_raycast_update()
		if VIS_Ray.is_colliding():
			var collider = VIS_Ray.get_collider()
			if collider == player and to_player.length() < closest_player_distance:
				closest_player = player
				closest_player_distance = to_player.length()
	return closest_player

func face_player(player : Player):
	if to_local(player.global_position).x * facing < 0:
		flip()

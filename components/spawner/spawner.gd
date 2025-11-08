extends Area2D
class_name Spawner

@onready var spawn_regions : Array[Node] = get_children()

@export var Mob_Scenes : Array[PackedScene]
@export var Spawn_Root : Node
@export_group("Continous")
@export var Rate: float = 0.5
@export_group("Once")
@export var Initial_Spawns : int = 10

func _ready():
	for i in Initial_Spawns:
		spawn()

var time_counter : float
func _physics_process(delta: float) -> void:
	time_counter += delta
	if time_counter >= 1/Rate:
		time_counter = 0
		spawn()

func spawn():
	var this_region : CollisionShape2D = spawn_regions.pick_random()
	var extents : Vector2 = (this_region.shape as RectangleShape2D).extents
	var local_random_position : Vector2 = Vector2(randf_range(-extents.x, extents.x), randf_range(-extents.y, extents.y))
	var mob : Entity = (Mob_Scenes.pick_random() as PackedScene).instantiate()
	mob.global_position = to_global(this_region.to_global(local_random_position))
	if Spawn_Root != null : Spawn_Root.add_child(mob)
	else : add_sibling(mob)

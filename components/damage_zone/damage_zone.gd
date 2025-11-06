extends Area2D
class_name DamageZone

@onready var collider = get_children()[0]
@onready var parent : Entity = get_parent()
@export var ray : RayCast2D

func _ready() -> void:
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, parent is Enemy)
	set_collision_mask_value(3, parent is Player)

func damage_all(amount):
	for body in get_overlapping_bodies():
		if body is not Entity or obstruction_check(body): continue
		if parent.facing != body.facing and body.get("protect"): continue
		body.take_damage(amount)

func obstruction_check(target : Entity) -> bool:
	ray.target_position = to_local(target.global_position)
	ray.force_raycast_update()
	var colliding_object = ray.get_collider()
	if colliding_object == target : return false
	else : return true

func flip():
	collider.scale.x *= -1

extends Node
class_name ProjectileLauncher

@export var projectile_scene : PackedScene
@export var offset : Vector2
@export var force : float

@onready var launched_by = get_parent()
var current_projectile : Projectile

func prepare(position: Vector2, dirction : int):
	current_projectile = projectile_scene.instantiate()
	current_projectile.global_position = position + Vector2(offset.x * dirction, offset.y)
	current_projectile.direction = dirction
	current_projectile.launched_by = launched_by
	get_tree().get_current_scene().add_child(current_projectile)

func launch():
	current_projectile.launch(force)

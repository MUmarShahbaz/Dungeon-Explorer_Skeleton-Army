extends Node
class_name ProjectileLauncher

@onready var parent : Entity = get_parent()
@export var move_list : Array[ProjectileAttack]
var attacking = null

func _process(delta: float) -> void:
	if attacking:
		if parent.check_anim(attacking) == false:
			attacking = null
	else:
		for projectile_attack : ProjectileAttack in move_list:
			if parent.check_frame(projectile_attack.Animation_Name, projectile_attack.Load_Animation_Frame):
				attacking = projectile_attack.Animation_Name
				var new_projectile : Projectile = projectile_attack.Projectile_Scene.instantiate()
				new_projectile.global_position = parent.global_position + Vector2(projectile_attack.Spawn_Offset.x * parent.facing, projectile_attack.Spawn_Offset.y)
				new_projectile.direction = parent.facing
				new_projectile.launched_by = parent
				get_tree().get_current_scene().add_child(new_projectile)
				await parent.await_frame(projectile_attack.Animation_Name, projectile_attack.Launch_Animation_Frame)
				if new_projectile: new_projectile.launch(projectile_attack.Force)

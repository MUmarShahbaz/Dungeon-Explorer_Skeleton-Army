extends RigidBody2D
class_name Projectile

@export var sprite: AnimatedSprite2D
@export var collider: CollisionShape2D
@export var damage : int = 10

var direction : int
var launched_by : CharacterBody2D

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(4, true)
	set_collision_mask_value(3 if launched_by is Player else 2, true)
	gravity_scale = 0
	lock_rotation = true
	contact_monitor = true
	max_contacts_reported = 1
	if direction == -1 : flip()
	while true:
		await get_tree().create_timer(5).timeout
		if abs(linear_velocity.x) < 2: queue_free()

func flip():
	sprite.flip_h = !sprite.flip_h
	collider.position.x *= -1

func _physics_process(_delta: float) -> void:
	var bodies = get_colliding_bodies()
	if bodies.size() > 0:
		if bodies[0] is Entity:
			if not (bodies[0] as Entity).get("protect") or (bodies[0] as Entity).facing == direction:
				(bodies[0] as Entity).take_damage(damage)
			(bodies[0] as Entity).velocity.x += 10*direction
		queue_free()

func launch(force : int) -> void:
	apply_impulse(Vector2(force * direction, 0))

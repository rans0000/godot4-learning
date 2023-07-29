extends Node3D
class_name EnemyProjectileControl;

@export var originalDamagable: Damagable;
@export var moveSpeed: float = 15;
@export var lifetime: float =3.0;

func _physics_process(delta: float) -> void:
	global_position += -global_transform.basis.z * moveSpeed * delta;
	lifetime -= delta;
	if (lifetime <= 0):
		queue_free();

extends Node

@export var projectileControl: EnemyProjectileControl;
@export var raycast: RayCast3D;

func _physics_process(_delta: float) -> void:
	if (raycast.is_colliding()):
		var hitTarget = (raycast.get_collider() as Node).get_node_or_null("Damagable");
		if (hitTarget != null && hitTarget is Damagable):
			if (hitTarget != projectileControl.originalDamagable):
				hitTarget.onHit();
			else :
				return;
		projectileControl.queue_free();

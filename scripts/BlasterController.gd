extends Node3D

@export var raycast: RayCast3D;
@export var laserEffect: PackedScene;

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("mouse_left_click")):
		fireShot();
	

func fireShot() -> void:
	var newLaser = laserEffect.instantiate() as Node3D;
	
	add_child(newLaser);
	newLaser.global_position = raycast.global_position;
	newLaser.global_rotation = raycast.global_rotation;
	
	if (raycast.is_colliding()):
		var impactPoint = raycast.get_collision_point();
		newLaser.scale = Vector3(newLaser.scale.x, newLaser.scale.y, impactPoint.distance_to(newLaser.global_position));
		var collider = (raycast.get_collider() as Node).get_node_or_null("Damagable");
		if (collider != null && collider is Damagable):
			collider.onHit();
	else:
		newLaser.scale = Vector3(newLaser.scale.x, newLaser.scale.y, raycast.target_position.length());

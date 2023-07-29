extends Node

@export var enemyCoreControl: EnemyCoreController;
@export var thisDamagable: Damagable;
@export var projectileScene: PackedScene;
@export var firingCooldown: float = 1.0;

var currentCooldown: float;

func _ready() -> void:
	currentCooldown = firingCooldown;

func _physics_process(delta: float) -> void:
	if (enemyCoreControl.targetBody != null):
		currentCooldown -= delta;
		if (currentCooldown <= 0):
			currentCooldown += firingCooldown;
			var projectile = projectileScene.instantiate() as EnemyProjectileControl;
			add_child(projectile);
			projectile.global_position = enemyCoreControl.global_position + Vector3.UP;
			projectile.look_at(enemyCoreControl.targetBody.global_position + Vector3(0, .25, 0));
			projectile.originalDamagable = thisDamagable as Damagable;

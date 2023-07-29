extends Node

@export var playerDamagable: DamagableEvent;
@export var victoryScreen: Control;
@export var lossScreen: Control;

func onEntityDeath() -> void:
	var enemyNodes = get_tree().get_nodes_in_group("EnemyDamagable");
	
	var enemyStillAlive = false;
	for enemy in enemyNodes:
		if (!enemy.is_queued_for_deletion() && enemy is DamagableEvent):
			if (enemy.HitPoints > 0):
				enemyStillAlive = true;
				break;
	
	if (!enemyStillAlive):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
		victoryScreen.visible = true;
		get_tree().paused = true;
		return;
	
	if (playerDamagable.HitPoints <= 0):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
		lossScreen.visible = true;
		get_tree().paused = true;

func restart() -> void:
	get_tree().paused = false;
	get_tree().reload_current_scene();

func quit() -> void:
	get_tree().paused = false;
	get_tree().quit();

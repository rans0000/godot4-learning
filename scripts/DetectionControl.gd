extends Node
class_name DetectionControl;

@export var enemyNavController: EnemyCoreController;

func onPlayerEnter(playerContainer: Node3D):
	enemyNavController.targetBody = playerContainer;

func  onPlayerExit():
	enemyNavController.targetBody = null;

extends Node3D
class_name EnemyNavController;

@export var targetBody: Node3D;
@export var movementSpeed: float;
@export var navigationAgent: NavigationAgent3D;

var movementDelta: float;
var lastPosition: Vector3;


func _process(_delta: float) -> void:
	if (targetBody != null && targetBody.global_position != lastPosition):
		lastPosition = targetBody.global_position;
		setTarget(lastPosition);

func setTarget(movementTarget: Vector3) -> void:
	navigationAgent.target_position = movementTarget;

func _physics_process(delta: float) -> void:
	if (navigationAgent.is_navigation_finished()):
		return;
	
	movementDelta = movementSpeed * delta;
	var nextPos: Vector3 = navigationAgent.get_next_path_position();
	var currentPos: Vector3 = global_transform.origin;
	var newVelocity:Vector3 = (nextPos - currentPos).normalized() * movementDelta;
	navigationAgent.set_velocity(newVelocity);

func On_NavigationAgent3DVelocityComputed(safeVelocity: Vector3) -> void:
	global_transform.origin = global_transform.origin.move_toward(global_transform.origin + safeVelocity, movementDelta);

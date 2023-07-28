extends Node3D
class_name EnemyCoreController;

@export var targetBody: Node3D;
@export var movementSpeed: float;
@export var navigationAgent: NavigationAgent3D;
@export var wanderUpdateCooldown: float = 2.0;
@export var wanderRange: float = 15.0;

var movementDelta: float;
var lastPosition: Vector3;
enum AIStates {Idle, Wandering, Chasing};
var currentState: AIStates;
var changeCooldown: float;

func _process(delta: float) -> void:
	updateState();
	
	match currentState:
		AIStates.Idle:
			changeCooldown -= delta;
			if (changeCooldown <= 0):
				changeCooldown = wanderUpdateCooldown;
				currentState = AIStates.Wandering;
				setTarget(getWanderingPosition())
		AIStates.Wandering:
			changeCooldown -= delta;
			if (changeCooldown <= 0):
				changeCooldown = wanderUpdateCooldown;
				currentState = AIStates.Idle;
		AIStates.Chasing:
			if (targetBody != null && targetBody.global_position != lastPosition):
				lastPosition = targetBody.global_position;
				setTarget(lastPosition);

func updateState() -> void:
	if (targetBody != null):
		currentState = AIStates.Chasing;
		return;
	if (currentState == AIStates.Chasing):
		currentState = AIStates.Idle;

func getWanderingPosition() -> Vector3:
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	return (global_position + Vector3(rng.randf_range(-wanderRange, wanderRange), 0, rng.randf_range(-wanderRange, wanderRange)));

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

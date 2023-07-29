extends Damagable
class_name  DamagableEvent;

@export var TransitionType: Tween.TransitionType;
@export var ScaleSize: Vector3;
@export var RotationDegrees: float;
@export var HitPoints: int;
@export var ContainerNode: Node3D;

signal  onDestruction;

var endOfGame: bool;
var originalPosition;
var originalRotation;
var originalScale;
var newTween: Tween;

func _ready() -> void:
	originalPosition = MeshReference.global_position;
	originalRotation = MeshReference.global_rotation_degrees;
	originalScale = MeshReference.scale;

func onDestroyed() -> void:
	endOfGame = true;
	HitPoints = 0;
	onHit();

func onCompleteDestruction() -> void:
	ContainerNode.queue_free();

func onHit():
	if (newTween != null && newTween.is_running()):
		newTween.stop();
	
	HitPoints -= 1;
	
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	MeshReference.material_override = HitMaterial;
	newTween = create_tween();
	newTween.set_trans(TransitionType);
	
#	newTween.tween_property(
#		MeshReference,
#		"global_position",
#		MeshReference.global_position + Vector3(0, 1, 0),
#		flashDuration/2
#	);
#	newTween.parallel();
	newTween.tween_property(
		MeshReference,
		"global_rotation_degrees",
		MeshReference.global_rotation_degrees + Vector3(
			wrap(rng.randf_range(-RotationDegrees, RotationDegrees), -180, 180),
			wrap(rng.randf_range(-RotationDegrees, RotationDegrees), -180, 180),
			wrap(rng.randf_range(-RotationDegrees, RotationDegrees), -180, 180)),
		flashDuration/2
	);
	newTween.parallel();
	newTween.tween_property(
		MeshReference,
		"scale",
		originalScale * ScaleSize,
		flashDuration/2
	);
	
	# Divider ----
	
#	newTween.tween_property(
#		MeshReference,
#		"global_position",
#		originalPosition,
#		flashDuration/2
#	);
#	newTween.parallel();
	newTween.tween_property(
		MeshReference,
		"global_rotation_degrees",
		originalRotation,
		flashDuration/2
	);
	newTween.parallel();
	newTween.tween_property(
		MeshReference,
		"scale",
		originalScale,
		flashDuration/2
	);
	
	if (endOfGame):
		newTween.connect("finished", onCompleteDestruction.bind());
	else:
		newTween.connect("finished", onReset.bind());
		if (HitPoints <= 0):
			get_tree().call_group("ScoringGroup", "onEntityDeath");
			newTween.connect("finished", onCompleteDestruction.bind());
			onDestruction.emit();
	
	newTween.play();

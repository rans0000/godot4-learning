extends Node3D
class_name Damagable

@export var MeshReference: GeometryInstance3D;
@export var BaseMaterial: Material;
@export var HitMaterial: Material;
@export var flashDuration: float = 0.2;

func onHit() -> void:
	MeshReference.material_override = HitMaterial;
	var timer = get_tree().create_timer(flashDuration);
	timer.connect("timeout", onReset.bind());

func onReset() -> void:
	MeshReference.material_override = BaseMaterial;

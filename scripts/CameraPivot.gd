extends Node3D

@export var verticalAngleLimit:float = 45;
@export var mouseSensitivity:float = 0.5;

var angleLimitInRad:float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	angleLimitInRad = deg_to_rad(verticalAngleLimit);

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x = clamp(rotation.x - deg_to_rad(event.relative.y * mouseSensitivity), -angleLimitInRad, angleLimitInRad);

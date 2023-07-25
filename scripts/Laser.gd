extends Node3D

@export var duration: float = 0.1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_tree().create_timer(duration);
	timer.connect("timeout", remove.bind());


func remove() -> void:
	queue_free();

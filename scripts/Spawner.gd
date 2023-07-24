extends Node3D

@export var SpawnLocation: Node3D;
@export var NodeToSpawn: PackedScene;

var spawnedNodes: Array;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("mouse_left_click")):
		var spawnNode = NodeToSpawn.instantiate() as Node3D;
		get_tree().root.get_child(0).add_child(spawnNode);
		spawnNode.global_position = SpawnLocation.global_position;
		spawnNode.global_rotation = SpawnLocation.global_rotation;
		spawnedNodes.append(spawnNode);
	
	if (event.is_action_pressed("mouse_right_click")):
		for node in spawnedNodes:
			node.queue_free();
		spawnedNodes.clear();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

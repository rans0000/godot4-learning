extends Area3D

@export var PlayerContainer: Node3D;

func onAreaEnter(body: Node3D) -> void:
	var aiDetection = body.get_node_or_null("Detection");
	if (aiDetection != null && aiDetection is DetectionControl):
		aiDetection.onPlayerEnter(PlayerContainer);

func onAreaExit(body: Node3D) -> void:
	var aiDetection = body.get_node_or_null("Detection");
	if (aiDetection != null && aiDetection is DetectionControl):
		aiDetection.onPlayerExit();

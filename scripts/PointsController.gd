extends Node

@export var ScoreLabel: Label;
@export var VictoryLabel: Label;

var CurrentPoints: int = 0;
var HasWon: bool;

func onPointsAdded(points: int) -> void:
	CurrentPoints += points;
	ScoreLabel.text = "Score: " + str(CurrentPoints);

func onVictory() -> void:
	if (HasWon):
		return;
	
	HasWon = true;
	get_tree().call_group("DamagableGroup", "onDestroyed");
	ScoreLabel.visible = false;
	VictoryLabel.visible = true;

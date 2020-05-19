extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$RightWall.position[0] = GlobalVars.currentResolution[0] + 40
	$RightWall.position[1] = GlobalVars.currentResolution[1] / 2
	$PlayerArea.position[0] = GlobalVars.currentResolution[0] / 2
	$PlayerArea.position[1] = GlobalVars.currentResolution[1] + 40
	$PlayerArea/PlayerAreaColl.shape.extents = Vector2(GlobalVars.currentResolution[0] / 2 - 20, 50)
	$EnemyArea.position[0] = GlobalVars.currentResolution[0] / 2
	$EnemyArea/EnemyAreaColl.shape.extents = Vector2(GlobalVars.currentResolution[0] / 2 - 20, 50)	

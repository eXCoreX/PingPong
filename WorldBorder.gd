extends StaticBody2D

func _ready():
	$RightWall.position[0] = GlobalVars.currentResolution[0] + 40
	$RightWall.position[1] = GlobalVars.currentResolution[1] / 2
	$PlayerArea.position[0] = GlobalVars.currentResolution[0] / 2
	$PlayerArea.position[1] = GlobalVars.currentResolution[1] + 40
	$PlayerArea/PlayerAreaColl.shape.extents = Vector2(GlobalVars.currentResolution[0] / 2 - 20, 50)
	var spritescalex = GlobalVars.currentResolution[0] / 1280
	$PlayerArea/Sprite.scale = Vector2(0.41 * spritescalex, 0.2)
	$EnemyArea.position[0] = GlobalVars.currentResolution[0] / 2
	$EnemyArea/EnemyAreaColl.shape.extents = Vector2(GlobalVars.currentResolution[0] / 2 - 20, 50)	
	$EnemyArea/Sprite.scale = Vector2(0.41 * spritescalex, 0.2)

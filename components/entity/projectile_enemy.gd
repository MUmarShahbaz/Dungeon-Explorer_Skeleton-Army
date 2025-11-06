extends Enemy
class_name ProjectileEnemy

func pounce(player):
	super.pounce(player)
	ANM_Animation_Tree.get("parameters/playback").travel("shoot")

extends Player
class_name Wizard

func primary():
	ANM_Animation_Tree.get("parameters/playback").travel("attack_1")

func secondary():
	ANM_Animation_Tree.get("parameters/playback").travel("secondary")

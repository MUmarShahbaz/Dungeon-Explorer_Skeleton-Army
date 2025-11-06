extends Player
class_name Wizard

func primary():
	if pause_movement(): return
	ANM_Animation_Tree.get("parameters/playback").travel("attack_1")

func secondary():
	if pause_movement(): return
	ANM_Animation_Tree.get("parameters/playback").travel("secondary")

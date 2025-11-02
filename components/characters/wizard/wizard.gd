extends Player
class_name Wizard

@export var primary_launcher: ProjectileLauncher
@export var secondary_launcher : ProjectileLauncher

func primary():
	if pause_movement(): return
	ANM_Animation_Tree.get("parameters/playback").travel("attack_1")
	await await_frame("attack_1", 0)
	primary_launcher.prepare(global_position, facing)
	await await_frame("attack_1", 5)
	primary_launcher.launch()
	
func secondary():
	if pause_movement(): return
	ANM_Animation_Tree.get("parameters/playback").travel("secondary")
	await await_frame("secondary", 9)
	secondary_launcher.prepare(global_position, facing)
	await await_frame("secondary", 12)
	secondary_launcher.launch()

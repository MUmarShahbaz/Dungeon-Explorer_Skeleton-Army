extends Control

@onready var HP_Bar : ProgressBar = $HBoxContainer/HP_Bar
@onready var Healing_Potions : Label = $"HBoxContainer/Healing Potions"
@onready var player : Player = get_tree().get_first_node_in_group("players")

func _process(delta: float) -> void:
	if player:
		HP_Bar.value = (player.HP_Health_Points / player.max_hp) * 100
		Healing_Potions.text = str(player.ITM_Healing_Potions)
	else: queue_free()

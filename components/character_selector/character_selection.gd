extends Control

@export var knight : PackedScene
@export var wizard : PackedScene
@export var hud : PackedScene

func _on_knight_pressed() -> void:
	var player : Knight = knight.instantiate()
	player.global_position = Vector2(24, -144)
	get_tree().current_scene.add_child(player)
	add_sibling(hud.instantiate())
	queue_free()

func _on_wizard_pressed() -> void:
	var player : Wizard = wizard.instantiate()
	player.global_position = Vector2(24, -144)
	get_tree().current_scene.add_child(player)
	add_sibling(hud.instantiate())
	queue_free()

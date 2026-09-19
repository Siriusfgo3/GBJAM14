
extends Node

var sounds = {
	"CannonShot": preload("res://audio/SFX/sounds/CannonShot.mp3")
}

func play_sound(key: String) -> void:
	if not sounds.has(key):
		print("Sound " + key + " not found!")
		return

	var player := AudioStreamPlayer.new()
	player.stream = sounds[key]
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)

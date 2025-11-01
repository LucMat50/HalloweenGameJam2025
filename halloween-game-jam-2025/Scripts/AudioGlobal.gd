extends Node

var backgroundMusicPlayer : AudioStreamPlayer = AudioStreamPlayer.new()
var soundEffectsPlayer : AudioStreamPlayer = AudioStreamPlayer.new()
var currentMusic : AudioStream

# PUT SOUND EFFECTS HERE AS PRELOADED AUDIO STREAMS 
# ex: var title_music : AudioStream = preload("res://assets/audio/title_music.wav")

func _ready() -> void:
	add_child(backgroundMusicPlayer)
	add_child(soundEffectsPlayer)

func playSoundEffect(sound_name : String) -> void:
	match sound_name:
		#ex: "bad_end_sfx":
				# soundEffectsPlayer.stream = bad_end_sfx
		pass
		
func changeMusic(music_name : String) -> void:
	match music_name:
		#ex:  "title":
		#	currentMusic = title_music
		pass
	
	backgroundMusicPlayer.stop()
	backgroundMusicPlayer.stream = currentMusic
	backgroundMusicPlayer.play()
			
	soundEffectsPlayer.play()

extends Node

var backgroundMusicPlayer : AudioStreamPlayer = AudioStreamPlayer.new()
var soundEffectsPlayer : AudioStreamPlayer = AudioStreamPlayer.new()
var footstepsPlayer : AudioStreamPlayer = AudioStreamPlayer.new()
var currentMusic : AudioStream

# PUT SOUND EFFECTS HERE AS PRELOADED AUDIO STREAMS 
# ex: var title_music : AudioStream = preload("res://assets/audio/title_music.wav")
var horror_ambience : AudioStream = preload("res://Assets/Audio/Music/horror_ambience.wav")
var background : AudioStream = preload("res://Assets/Audio/Music/background-ambience.wav")

var footstep : AudioStream = preload("res://Assets/Audio/SFX/wood_footstep.wav")

var oink : AudioStream = preload("res://Assets/Audio/SFX/oink.wav")
var moo : AudioStream = preload("res://Assets/Audio/SFX/moo.wav")
var door_open : AudioStream = preload("res://Assets/Audio/SFX/open_door.wav")
var hose : AudioStream = preload("res://Assets/Audio/SFX/hose.mp3")
var car : AudioStream = preload("res://Assets/Audio/SFX/start_car.wav")

func _ready() -> void:
	add_child(backgroundMusicPlayer)
	add_child(soundEffectsPlayer)
	add_child(footstepsPlayer)
	footstepsPlayer.stream = footstep
	backgroundMusicPlayer.volume_db = -20.0
	footstepsPlayer.volume_db = 0.0
	footstepsPlayer.pitch_scale = 2.0

func playSoundEffect(sound_name : String) -> void:
	match sound_name:
		#ex: "bad_end_sfx":
				# soundEffectsPlayer.stream = bad_end_sfx
		"oink":
			soundEffectsPlayer.stream = oink
		"moo":
			soundEffectsPlayer.stream = moo
		"door_open":
			soundEffectsPlayer.stream = door_open
		"hose":
			soundEffectsPlayer.stream = hose
		"car":
			soundEffectsPlayer.stream = car
	
	soundEffectsPlayer.play()
		
func changeMusic(music_name : String) -> void:
	match music_name:
		#ex:  "title":
		#	currentMusic = title_music
		"horror_ambience":
			currentMusic = horror_ambience
		"background":
			currentMusic = background
	
	backgroundMusicPlayer.stop()
	backgroundMusicPlayer.stream = currentMusic
	backgroundMusicPlayer.play()
	
func pauseMusic() -> void:
	backgroundMusicPlayer.stop()
	soundEffectsPlayer.stop()
	
func playFootstep():
	footstepsPlayer.play()
	
func stopFootstep():
	footstepsPlayer.stop()
	

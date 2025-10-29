extends Resource
class_name Puzzle

@export var active : bool = false
@export var solved : bool = false
@export var requiredItems : Array[InvItem]
@export var prerequisitePuzzles : Array[Puzzle]
@export var prereqNotMetTimeline : String
@export var puzzlesToActivate : Array[Puzzle]

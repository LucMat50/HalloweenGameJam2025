extends Node

var inv : Inv
var dialog : DialogManager

func isPuzzleSolved(puzzle : Puzzle) -> bool:
	if !puzzle.active:
		return false
	if puzzle.prerequisitePuzzles.size() > 0:
		for p in puzzle.prerequisitePuzzles:
			if !p.solved:
				return false
	if puzzle.requiredItems.size() > 0:
		for i in puzzle.requiredItems:
			if inv.hasItem(i):
				return true
	else:
		return true
	return false

func tryPuzzle(item : InvItem) -> bool:
	var puzzle = item.puzzle
	if isPuzzleSolved(puzzle):
		inv.insert(item)
		dialog.start_dialog(item.description_timeline)
		dialog.show_image(item.texture)
		puzzle.solved = true
		for p in puzzle.puzzlesToActivate:
			activatePuzzle(p)
		return true
	else:
		if puzzle.prereqNotMetTimeline == "":
			dialog.start_dialog("PrereqNotMetBasic")
		else:
			dialog.start_dialog(puzzle.prereqNotMetTimeline)
		print("Missing something to complete")
		return false
		
func activatePuzzle(puzzle : Puzzle):
	puzzle.active = true

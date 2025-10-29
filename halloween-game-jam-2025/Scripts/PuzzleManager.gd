extends Node

var inv : Inv
var dialog : DialogManager

func tryPuzzle(item : InvItem) -> bool:
	if isPuzzleSolved(item.puzzle):
		inv.insert(item)
		dialog.start_dialog(item.description_timeline)
		dialog.show_image(item.texture)
		item.puzzle.solved = true
		return true
	else:
		if item.puzzle.prereqNotMetTimeline == "":
			dialog.start_dialog("PrereqNotMetBasic")
		else:
			dialog.start_dialog(item.puzzle.prereqNotMetTimeline)
		print("Missing something to complete")
		return false

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
		

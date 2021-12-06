extends AbstractDay

func getTitle() -> String:
	return "Day 6: Lanternfish"

func getInputNumbers():
	var inputs = puzzleInput.text.split(",", false)
	var numbers = [];
	for n in inputs:
		numbers.append(int(n))
	return numbers

func calculatePart1():
	var numbers = getInputNumbers()
	var fishes = Utility.fill_array(9)
	for n in numbers:
		fishes[n] += 1
	for i in range(0, 80):
		var newFish = Utility.fill_array(9)
		var newFishCount = fishes[0]
		for p in range(8, 0, -1):
			newFish[p-1] = fishes[p]
		newFish[8] = newFishCount
		newFish[6] += newFishCount
		fishes = newFish
	return Utility.array_sum(fishes)

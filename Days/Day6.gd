extends AbstractDay

func getTitle() -> String:
	return "Day 6: Lanternfish"

func getInputNumbers():
	var inputs = puzzleInput.text.split(",", false)
	var numbers = [];
	for n in inputs:
		numbers.append(int(n))
	return numbers

func simulateFishes(fishes, maxGeneration):
	for i in range(0, maxGeneration):
		var newFish = Utility.fill_array(9)
		var newFishCount = fishes[0]
		for p in range(8, 0, -1):
			newFish[p-1] = fishes[p]
		newFish[8] = newFishCount
		newFish[6] += newFishCount
		fishes = newFish
	return fishes

func calculatePart1():
	var numbers = getInputNumbers()
	var fishes = Utility.fill_array(9)
	for n in numbers:
		fishes[n] += 1
	fishes = simulateFishes(fishes, 80)
	return Utility.array_sum(fishes)

func calculatePart2():
	var numbers = getInputNumbers()
	var fishes = Utility.fill_array(9)
	for n in numbers:
		fishes[n] += 1
	fishes = simulateFishes(fishes, 256)
	return Utility.array_sum(fishes)

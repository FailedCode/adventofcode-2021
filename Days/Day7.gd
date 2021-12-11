extends AbstractDay

func getTitle() -> String:
	return "Day 7: The Treachery of Whales"

func getInputNumbers():
	var inputs = puzzleInput.text.split(",", false)
	var numbers = []
	for i in inputs:
		numbers.append(int(i))
	numbers.sort()
	return numbers
	
func calculatePart1():
	var numbers = getInputNumbers()
	return findMinimalFuel(numbers)
	
func findMinimalFuel(numbers):
	var fuelMin = null
	var targetNumberLast = -1
	for position in range(0, numbers.size()):
		var targetNumber = numbers[position]
		if targetNumber != targetNumberLast:
			targetNumberLast = targetNumber
		else:
			continue
		var fuel = fuelconsumption(numbers, targetNumber)
		if fuelMin == null || fuel < fuelMin:
			fuelMin = fuel
	return fuelMin


func fuelconsumption(numbers, targetValue):
	var fuel = 0
	for n in numbers:
		fuel += max(n, targetValue) - min(n, targetValue)
	return fuel

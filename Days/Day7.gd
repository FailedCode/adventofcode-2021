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
	return findMinimalFuel(numbers, "fuelconsumptionLinear")
	
func calculatePart2():
	var numbers = getInputNumbers()
	return findMinimalFuel(numbers, "fuelconsumptionAdditive")

func findMinimalFuel(numbers, calcFunction):
	var fuelconsumption = funcref(self, calcFunction)
	var fuelMin = null
	for targetNumber in range(numbers[0], numbers[numbers.size() - 1]):
		var fuel = fuelconsumption.call_func(numbers, targetNumber)
		if fuelMin == null || fuel < fuelMin:
			fuelMin = fuel
	return fuelMin

func fuelconsumptionLinear(numbers, targetValue):
	var fuel = 0
	for n in numbers:
		fuel += max(n, targetValue) - min(n, targetValue)
	return fuel

func fuelconsumptionAdditive(numbers, targetValue):
	var fuel = 0
	for n in numbers:
		var diff = max(n, targetValue) - min(n, targetValue)
		fuel += diff * (diff + 1) / 2
	return fuel

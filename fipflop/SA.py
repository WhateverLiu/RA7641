import six
import sys
sys.modules['sklearn.externals.six'] = six
import mlrose
import numpy as np
import time


probSize = int(sys.argv[2])
initialTemp = float(sys.argv[4])
tempDecay = float(sys.argv[6])
minTemp = float(sys.argv[8])
maxIter = int(sys.argv[10])
rseed = int(sys.argv[12])


# Random neighbor is implemented as flipping one digit.
fitnessF = mlrose.FlipFlop()
problemFit = mlrose.DiscreteOpt(length = probSize, fitness_fn = fitnessF, maximize = True, max_val = 2)
# max_val: number of unique values each element in the state vector can take.
schedule = mlrose.ExpDecay(init_temp = initialTemp, exp_const = tempDecay, min_temp = minTemp)


timeStart = time.time()
best_state, best_fitness, fitness_curve = mlrose.simulated_annealing(
  problemFit, schedule = schedule, max_attempts = int(1e9),
  max_iters = maxIter, init_state = None, curve = True, random_state = rseed)
timeEnd = time.time()
timeCost = timeEnd - timeStart


timeCost = str(timeCost)
best_state = ",".join(map(str, best_state))
fitness_curve = ",".join(map(str, fitness_curve))
rst = [timeCost, best_fitness, best_state, fitness_curve]
fileName = ( "output/SA-psiz-" + str(probSize) + 
"-iniT-" + str(initialTemp) + 
"-Tdcy-" + str(tempDecay) + 
"-Tmin-" + str(minTemp) + 
"-mxit-" + str(maxIter) + 
"-seed-" + str(rseed) + '-.txt')
with open(fileName, 'w') as f:
  for item in rst: f.write("%s\n" % item)



  
  



















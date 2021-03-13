import six
import sys
sys.modules['sklearn.externals.six'] = six
import mlrose
import numpy as np
import time


probSize = int(sys.argv[2])
popu = int(sys.argv[4])
mutP = float(sys.argv[6])
maxIter = int(sys.argv[8])
rseed = int(sys.argv[10])



fitnessF = mlrose.FlipFlop()
problemFit = mlrose.DiscreteOpt(length = probSize, fitness_fn = fitnessF, maximize = True, max_val = 2)
# max_val: number of unique values each element in the state vector can take.


timeStart = time.time()
# Double checked. The new generation does not take in parent generation.
best_state, best_fitness, fitness_curve = mlrose.genetic_alg(
  problemFit, pop_size = popu, mutation_prob = mutP, max_attempts = int(1e9), max_iters = maxIter,
  curve = True, random_state = rseed)
timeEnd = time.time()
timeCost = timeEnd - timeStart


timeCost = str(timeCost)
best_state = ",".join(map(str, best_state))
fitness_curve = ",".join(map(str, fitness_curve))
rst = [timeCost, best_fitness, best_state, fitness_curve]
fileName = ( "output/GA-psiz-" + str(probSize) + 
"-popu-" + str(popu) + 
"-mutP-" + str(mutP) + 
"-mxit-" + str(maxIter) + 
"-seed-" + str(rseed) + '-.txt')
with open(fileName, 'w') as f:
  for item in rst: f.write("%s\n" % item)



  
  



















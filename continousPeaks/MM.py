import six
import sys
sys.modules['sklearn.externals.six'] = six
import mlrose
import numpy as np
import time


probSize = int(sys.argv[2])
thre = float(sys.argv[4])
popu = int(sys.argv[6])
kepp = float(sys.argv[8])
maxIter = int(sys.argv[10])
rseed = int(sys.argv[12])


fitnessF = mlrose.ContinuousPeaks(t_pct = thre)
problemFit = mlrose.DiscreteOpt(length = probSize, fitness_fn = fitnessF, maximize = True, max_val = 2)
# max_val: number of unique values each element in the state vector can take.


timeStart = time.time()
best_state, best_fitness, fitness_curve = mlrose.mimic(
  problemFit, pop_size = popu, keep_pct = kepp, max_attempts = int(1e9),
  max_iters = maxIter, curve = True, random_state = rseed, fast_mimic = True)
timeEnd = time.time()
timeCost = timeEnd - timeStart


timeCost = str(timeCost)
best_state = ",".join(map(str, best_state))
fitness_curve = ",".join(map(str, fitness_curve))
rst = [timeCost, best_fitness, best_state, fitness_curve]
fileName = ( "output/MM-psiz-" + str(probSize) + 
"-thre-" + str(thre) + 
"-popu-" + str(popu) + 
"-kepp-" + str(kepp) + 
"-mxit-" + str(maxIter) + 
"-seed-" + str(rseed) + '-.txt')
with open(fileName, 'w') as f:
  for item in rst: f.write("%s\n" % item)



  
  



















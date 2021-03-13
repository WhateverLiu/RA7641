import six
import sys
sys.modules['sklearn.externals.six'] = six
import mlrose
import numpy as np
import time
# from sklearn.preprocessing import MinMaxScaler, OneHotEncoder
from sklearn.preprocessing import OneHotEncoder
from sklearn.metrics import accuracy_score


splitN = int(sys.argv[2])
lrte = float(sys.argv[4])
clmx = float(sys.argv[6])
mxit = int(sys.argv[8])
rsed = int(sys.argv[10])


dat = np.loadtxt(open("data/digit.csv", "rb"), delimiter = ",", skiprows = 1)
target = dat[:, dat.shape[1] - 1].flatten().astype(np.int32)
V = dat[:, 0:(dat.shape[1] - 1)]
Xtrain = V[0:splitN] # 70% of data are training data.
endN = min(splitN + splitN, 5540)
Xtest = V[splitN:endN]
ytrain = target[0:splitN]
ytest = target[splitN:endN]


oneH = OneHotEncoder()
ytrain = oneH.fit_transform(ytrain.reshape(-1, 1)).todense()
ytest = oneH.fit_transform(ytest.reshape(-1, 1)).todense()




timeCostAvg = 0.0
ytrainAccAvg = 0.0
ytestAccAvg = 0.0
fitnessAvg = np.zeros(mxit)
Ntry = 10


for i in range(Ntry):
  model = mlrose.NeuralNetwork(
  hidden_nodes = [16], activation = 'relu', algorithm = 'random_hill_climb', max_iters = mxit,
  bias = True, is_classifier = True, learning_rate = lrte,
  early_stopping = False, clip_max = clmx, restarts = 0,
  max_attempts = int(1e9), mutation_prob = 0, pop_size = 0,
  random_state = rsed + i, curve = True)
  
  
  timeStart = time.time()
  model.fit(Xtrain, ytrain)
  timeEnd = time.time()
  timeCost = timeEnd - timeStart
  timeCostAvg += timeCost
  

  ytrainPred = model.predict(Xtrain)
  ytrainAcc = accuracy_score(ytrain, ytrainPred)
  ytrainAccAvg += ytrainAcc
  

  ytestPred = model.predict(Xtest)
  ytestAcc = accuracy_score(ytest, ytestPred)
  ytestAccAvg += ytestAcc

  
  fitnessAvg += model.fitness_curve




timeCost = str(timeCostAvg / Ntry)
trainRst = str(ytrainAccAvg / Ntry)
testRst = str(ytestAccAvg / Ntry)
fitness_curve = ",".join(map(str, fitnessAvg / Ntry))
rst = [timeCost, trainRst, testRst, fitness_curve]
fileName = ( "output/RH-Ntrn-" + str(splitN) + 
"-lrte-" + str(lrte) +
"-clmx-" + str(clmx) +
"-mxit-" + str(mxit) + 
"-seed-" + str(rsed) + '-.txt' )
with open(fileName, 'w') as f:
  for item in rst: f.write("%s\n" % item)














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
popu = int(sys.argv[8])
mutP = float(sys.argv[10])
mxit = int(sys.argv[12])
rsed = int(sys.argv[14])


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


model = mlrose.NeuralNetwork(
  hidden_nodes = [16], activation = 'relu', algorithm = 'genetic_alg', max_iters = mxit,
  bias = True, is_classifier = True, learning_rate = lrte,
  early_stopping = False, clip_max = clmx, restarts = 0,
  max_attempts = int(1e9), mutation_prob = mutP, pop_size = popu,
  random_state = rsed, curve = True)
  
  
timeStart = time.time()
model.fit(Xtrain, ytrain)
timeEnd = time.time()
timeCost = timeEnd - timeStart


weightsDescribe = [np.min(model.fitted_weights), 
  np.mean(model.fitted_weights), 
  np.max(model.fitted_weights)]
weightsDescribe = ",".join(map(str, weightsDescribe))


ytrainPred = model.predict(Xtrain)
ytrainAcc = accuracy_score(ytrain, ytrainPred)


ytestPred = model.predict(Xtest)
ytestAcc = accuracy_score(ytest, ytestPred)


timeCost = str(timeCost)
trainRst = str(ytrainAcc)
testRst = str(ytestAcc)
fitness_curve = ",".join(map(str, model.fitness_curve))
rst = [timeCost, trainRst, testRst, weightsDescribe, fitness_curve]
fileName = ( "output/GA-Ntrn-" + str(splitN) + 
"-lrte-" + str(lrte) +
"-clmx-" + str(clmx) +
"-popu-" + str(popu) + 
"-mutP-" + str(mutP) + 
"-mxit-" + str(mxit) + 
"-seed-" + str(rsed) + '-.txt' )
with open(fileName, 'w') as f:
  for item in rst: f.write("%s\n" % item)














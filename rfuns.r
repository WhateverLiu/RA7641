

readit = function(fname, RH = F, RHrestarts = 10)
{
  x = readLines(fname)
  if(!RH)
  {
    t = as.numeric(x[1])
    optY = as.numeric(x[2])
    fitnessHist = as.numeric(strsplit(x[4], ",")[[1]])
    return(list(time = t, optY = optY, fitnessHist = fitnessHist))
  }
  
  
  t = as.numeric(x[1])
  fitnessHist = rowMeans(matrix(as.numeric(strsplit(x[4], ",")[[1]]), ncol = RHrestarts + 1))
  optY = tail(fitnessHist, n = 1)
  list(time = t, optY = optY, fitnessHist = fitnessHist)
}














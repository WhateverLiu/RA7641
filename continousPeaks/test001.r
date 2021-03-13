

# Global maximum = N + N - (T + 1)
# problemSize = 100
threshold = 0.1
globalMax = function(problemSize) { problemSize * 2 - (problemSize * threshold + 1) }



system(paste0("python RH.py problemSize ", problemSize, " threshold ", threshold, " restarts 10 maxIter 1000 randSeed 42"), wait = F)


system(paste0("python SA.py problemSize ", problemSize, " threshold ", threshold, " initialTemp 13 tempDecay 0.05 minTemp 0.1 maxIter 1000 randSeed 42"), wait = F)


system(paste0("python GA.py problemSize ", problemSize, " threshold ", threshold, " population 200 mutationP 0.1 maxIter 1000 randSeed 42"), wait = F)


system(paste0("python MM.py problemSize ", problemSize, " threshold ", threshold, " population 200 subsampleRatio 0.3 maxIter 1000 randSeed 42"), wait = F)


# Lowering the maximum size to 80. Produce tuning plots.
if(T)
{
  
  
  problemSize = 80
  
  
  randSeed = 42:51
  # MM
  for(i in 1:length(randSeed))
  {
    system(paste0("python MM.py problemSize ", problemSize, " threshold ", threshold, " population 200 subsampleRatio 0.1 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python MM.py problemSize ", problemSize, " threshold ", threshold, " population 200 subsampleRatio 0.2 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python MM.py problemSize ", problemSize, " threshold ", threshold, " population 200 subsampleRatio 0.3 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python MM.py problemSize ", problemSize, " threshold ", threshold, " population 200 subsampleRatio 0.4 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python MM.py problemSize ", problemSize, " threshold ", threshold, " population 200 subsampleRatio 0.5 maxIter 1000 randSeed ", randSeed[i]), wait = F)
  }
  
  
  # GA
  for(i in 1:length(randSeed))
  {
    system(paste0("python GA.py problemSize ", problemSize, " threshold ", threshold, " population 200 mutationP 0.05 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python GA.py problemSize ", problemSize, " threshold ", threshold, " population 200 mutationP 0.1 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python GA.py problemSize ", problemSize, " threshold ", threshold, " population 200 mutationP 0.15 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python GA.py problemSize ", problemSize, " threshold ", threshold, " population 200 mutationP 0.2 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python GA.py problemSize ", problemSize, " threshold ", threshold, " population 200 mutationP 0.25 maxIter 1000 randSeed ", randSeed[i]), wait = F)
  }
  
  
  
  # "RH-psiz-450-thre-0.1-rstr-10-mxit-1000"
  # Feel about RH and determine SA
  if(F)
  {
    
    source("../rfuns.r")
    # tmp = paste0("output/", list.files("output")[grepl("RH-psiz-", list.files("output"))])
    # tmp = tmp[order(unlist(lapply(strsplit(tmp, split = "-"), function(x) as.integer(x[3]))))]
    # tmp = sapply(tmp, function(x) readit(x, RH = T, RHrestarts = 10))
    tmp = readit("output/RH-psiz-80-thre-0.1-rstr-10-mxit-1000-seed-42-.txt", RH = T, RHrestarts = 10)
    globalMax(80)
    
    
  }
  
  
  # SA
  for(i in 1:length(randSeed))
  {
    system(paste0("python SA.py problemSize ", problemSize, " threshold ", threshold, " initialTemp 16 tempDecay 0.05 minTemp 0.1 maxIter 10000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python SA.py problemSize ", problemSize, " threshold ", threshold, " initialTemp 13 tempDecay 0.05 minTemp 0.1 maxIter 10000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python SA.py problemSize ", problemSize, " threshold ", threshold, " initialTemp 10 tempDecay 0.05 minTemp 0.1 maxIter 10000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python SA.py problemSize ", problemSize, " threshold ", threshold, " initialTemp 7 tempDecay 0.05 minTemp 0.1 maxIter 10000 randSeed ", randSeed[i]), wait = F)
    system(paste0("python SA.py problemSize ", problemSize, " threshold ", threshold, " initialTemp 4 tempDecay 0.05 minTemp 0.1 maxIter 10000 randSeed ", randSeed[i]), wait = F)
  }
  
  
  # RH
  system(paste0("python RH.py problemSize ", problemSize, " threshold ", threshold, " restarts 10 maxIter 10000 randSeed 42"), wait = F)

}




# Plots for the largest instance.
source("../rfuns.r")
if(T)
{
  
  
  # GA, tune.
  if(T)
  {
    
    tmp = list()
    for(i in 1:length(randSeed))
    { 
      tmp[[i]] = paste0("output/",c(
        paste0("GA-psiz-80-thre-0.1-popu-200-mutP-0.25-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("GA-psiz-80-thre-0.1-popu-200-mutP-0.2-mxit-1000-seed-", randSeed[i], "-.txt"),
        paste0("GA-psiz-80-thre-0.1-popu-200-mutP-0.15-mxit-1000-seed-", randSeed[i], "-.txt"),
        paste0("GA-psiz-80-thre-0.1-popu-200-mutP-0.1-mxit-1000-seed-", randSeed[i], "-.txt"),
        paste0("GA-psiz-80-thre-0.1-popu-200-mutP-0.05-mxit-1000-seed-", randSeed[i], "-.txt"))) 
    }
    tmp = lapply(1:length(tmp[[1]]), function(i) unlist(lapply(tmp, function(x) x[[i]])))
    tmp = lapply(tmp, function(x) 
    {
      tmp = lapply(x, function(y)
      {
        if(!file.exists(y)) return(NULL)
        readit(y)$fitnessHist
      })
      rowMeans(as.data.frame(tmp[unlist(lapply(tmp, function(x) !is.null(x)))]))
    })
    
    
    ylim = c(min(unlist(tmp)), 151)
    pdf("figure/GA-mutP.pdf", width = 8, height = 8 * 0.618)
    par(mar = c(4.1, 5, 0, 0), family = "serif")
    plot(0, col = "white", bty = "L", xlim = c(1, length(tmp[[1]])), ylim = ylim, cex.lab = 2, cex.axis = 1.5, xlab = "Iteration", ylab = "Fitness")
    thecols = c("black", "blue", "darkgreen", "red", "orange")
    legend("bottomright", legend = c("Mutation Pr", "0.25", "0.2", "0.15", "0.1", "0.05"), col = c("white", thecols), pch = rep(15, 6), bty = "n", cex = 1.5)
    for(i in 1:length(tmp))
    {
      lines(tmp[[i]], col = thecols[i], lwd = 2)
    }
    dev.off()
    
  }
  
  
  # MM tune.
  if(T)
  {
    
    tmp  = list()
    for(i in 1:length(randSeed))
    {
      tmp[[i]] = paste0("output/",c(
        paste0("MM-psiz-80-thre-0.1-popu-200-kepp-0.5-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("MM-psiz-80-thre-0.1-popu-200-kepp-0.4-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("MM-psiz-80-thre-0.1-popu-200-kepp-0.3-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("MM-psiz-80-thre-0.1-popu-200-kepp-0.2-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("MM-psiz-80-thre-0.1-popu-200-kepp-0.1-mxit-1000-seed-", randSeed[i], "-.txt")))
    }
    
    
    tmp = lapply(1:length(tmp[[1]]), function(i) unlist(lapply(tmp, function(x) x[[i]])))
    tmp = lapply(tmp, function(x) 
    {
      tmp = lapply(x, function(y)
      {
        if(!file.exists(y)) return(NULL)
        readit(y)$fitnessHist
      })
      rowMeans(as.data.frame(tmp[unlist(lapply(tmp, function(x) !is.null(x)))]))
    })
    
    
    ylim = c(min(unlist(tmp)), 151)
    pdf("figure/MM-kepp.pdf", width = 8, height = 8 * 0.618)
    par(mar = c(4.1, 5, 0, 0), family = "serif")
    plot(0, col = "white", bty = "L", xlim = c(1, length(tmp[[1]])), ylim = ylim, cex.lab = 2, cex.axis = 1.5, xlab = "Iteration", ylab = "Fitness")
    thecols = c("black", "blue", "darkgreen", "red", "orange")
    legend("bottomright", legend = c("Percentile", "0.5", "0.4", "0.3", "0.2", "0.1"), col = c("white", thecols), pch = rep(15, 6), bty = "n", cex = 1.5)
    for(i in 1:length(tmp))
    {
      lines(tmp[[i]], col = thecols[i], lwd = 2)
    }
    dev.off()
    
    
  }
  
  
  # SA tune.
  if(T)
  {
    
    
    tmp  = list()
    for(i in 1:length(randSeed))
    {
      tmp[[i]] = paste0("output/",c(
        paste0("SA-psiz-80-thre-0.1-iniT-16.0-Tdcy-0.05-Tmin-0.1-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("SA-psiz-80-thre-0.1-iniT-13.0-Tdcy-0.05-Tmin-0.1-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("SA-psiz-80-thre-0.1-iniT-10.0-Tdcy-0.05-Tmin-0.1-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("SA-psiz-80-thre-0.1-iniT-7.0-Tdcy-0.05-Tmin-0.1-mxit-1000-seed-", randSeed[i], "-.txt"), 
        paste0("SA-psiz-80-thre-0.1-iniT-4.0-Tdcy-0.05-Tmin-0.1-mxit-1000-seed-", randSeed[i], "-.txt")))
    }
    
    
    tmp = lapply(1:length(tmp[[1]]), function(i) unlist(lapply(tmp, function(x) x[[i]])))
    tmp = lapply(tmp, function(x) 
    {
      tmp = lapply(x, function(y)
      {
        if(!file.exists(y)) return(NULL)
        readit(y)$fitnessHist
      })
      rowMeans(as.data.frame(tmp[unlist(lapply(tmp, function(x) !is.null(x)))]))
    })
    
    
    ylim = c(min(unlist(tmp)), 151)
    pdf("figure/SA-Temp-0.5-1000iter.pdf", width = 8, height = 8 * 0.618)
    par(mar = c(4.1, 5, 0, 0), family = "serif")
    plot(0, col = "white", bty = "L", xlim = c(1, length(tmp[[1]])), ylim = ylim, cex.lab = 2, cex.axis = 1.5, xlab = "Iteration", ylab = "Fitness")
    thecols = c("black", "blue", "darkgreen", "red", "orange")
    legend("bottomright", legend = c("Temp", "16, --0.05", "13, --0.05", "10,  --0.05", "7,  --0.05", "4,  --0.05"), col = c("white", thecols), pch = rep(15, 6), bty = "n", cex = 1.5)
    for(i in 1:length(tmp))
    {
      lines(tmp[[i]], col = thecols[i], lwd = 2)
    }
    dev.off()
    
    
  }
  
  
  # RH average
  if(T)
  {
    
    
    tmp = readit("output/RH-psiz-80-thre-0.1-rstr-10-mxit-10000-seed-42-.txt", RH = T, RHrestarts = 10)
    ylim = c(min(unlist(tmp$fitnessHist)), 151)
    pdf("figure/RHavg-10000iter.pdf", width = 8, height = 8 * 0.618)
    par(mar = c(4.1, 5, 0, 0), family = "serif")
    plot(tmp$fitnessHist, bty = "L", cex.lab = 2, cex.axis = 1.5, xlab = "Iteration", ylab = "Fitness", ylim = ylim, type = "l", lwd = 2)
    dev.off()
    
    
  }
  
  
}



# Based on the optimal parameters on the largest instance, 
# Rerun 30 ~ 80.
if(T)
{
  
  
  randSeed = 42:51
  problemSize = seq(30, 80, by = 10)
  # MM
  for(i in 1:length(randSeed))
  {
    for(k in 1:length(problemSize))
    {
      system(paste0("python MM.py problemSize ", problemSize[k], " threshold ", threshold, " population 200 subsampleRatio 0.3 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    }
  }
  
  
  # GA
  for(i in 1:length(randSeed))
  {
    for(k in 1:length(problemSize))
    {
      system(paste0("python GA.py problemSize ", problemSize[k], " threshold ", threshold, " population 200 mutationP 0.05 maxIter 1000 randSeed ", randSeed[i]), wait = F)
    }
  }
  
  
  for(i in 1:length(randSeed))
  {
    for(k in 1:length(problemSize))
    {
      system(paste0("python SA.py problemSize ", problemSize[k], " threshold ", threshold, " initialTemp 16 tempDecay 0.05 minTemp 0.1 maxIter 10000 randSeed ", randSeed[i]), wait = F)
    }
  }
  
  
  # RH
  for(k in 1:length(problemSize))
  {
    system(paste0("python RH.py problemSize ", problemSize[i], " threshold ", threshold, " restarts 10 maxIter 10000 randSeed 42"), wait = F)
  }
  
  
}




# Plot N(evaluation) vs problem size.
source("../rfuns.r")
if(T)
{
  
  
  # MM
  MMrstByProbSize = list()
  for(k in 1:length(problemSize))
  {
    n = problemSize[k]
    tmp = list()
    # MM-psiz-40-thre-0.1-popu-200-kepp-0.3-mxit-1000-seed-45-
    for(i in 1:length(randSeed))
    {
      sed = randSeed[i]
      fname = paste0("output/MM-psiz-", n, "-thre-0.1-popu-200-kepp-0.3-mxit-1000-seed-", sed, "-.txt")
      if(!file.exists(fname)) next
      tmp[[length(tmp) + 1]] = readit(fname, RH = F, RHrestarts = 10)
    }
    # list(time = t, optY = optY, fitnessHist = fitnessHist)
    t = mean(unlist(lapply(tmp, function(x) x$time)))
    optY = mean(unlist(lapply(tmp, function(x) x$optY)))
    fitnessHist = rowMeans(as.data.frame(lapply(tmp, function(x) x$fitnessHist)))
    convergedIter = length(fitnessHist) - which(abs(diff(rev(fitnessHist))) > 1e-3)[1]
    MMrstByProbSize[[k]] = list(time = t, optY = optY, fitnessHist = fitnessHist, convergedIter = convergedIter)
  }
 
  
  
  
  # GA
  GArstByProbSize = list()
  for(k in 1:length(problemSize))
  {
    n = problemSize[k]
    tmp = list()
    for(i in 1:length(randSeed))
    {
      sed = randSeed[i]
      fname = paste0("output/GA-psiz-", n, "-thre-0.1-popu-200-mutP-0.05-mxit-1000-seed-", sed, "-.txt")
      if(!file.exists(fname)) next
      tmp[[length(tmp) + 1]] = readit(fname, RH = F, RHrestarts = 10)
    }
    # list(time = t, optY = optY, fitnessHist = fitnessHist)
    t = mean(unlist(lapply(tmp, function(x) x$time)))
    optY = mean(unlist(lapply(tmp, function(x) x$optY)))
    fitnessHist = rowMeans(as.data.frame(lapply(tmp, function(x) x$fitnessHist)))
    convergedIter = length(fitnessHist) - which(abs(diff(rev(fitnessHist))) > 1e-3)[1]
    GArstByProbSize[[k]] = list(time = t, optY = optY, fitnessHist = fitnessHist, convergedIter = convergedIter)
  }
  
  
  
  
  # SA
  SArstByProbSize = list()
  for(k in 1:length(problemSize))
  {
    n = problemSize[k]
    tmp = list()
    for(i in 1:length(randSeed))
    {
      sed = randSeed[i]
      # SA-psiz-30-thre-0.1-iniT-16.0-Tdcy-0.05-Tmin-0.1-mxit-10000-seed-46-
      fname = paste0("output/SA-psiz-", n, "-thre-0.1-iniT-16.0-Tdcy-0.05-Tmin-0.1-mxit-10000-seed-", sed, "-.txt")
      if(!file.exists(fname)) next
      tmp[[length(tmp) + 1]] = readit(fname, RH = F, RHrestarts = 10)
    }
    # list(time = t, optY = optY, fitnessHist = fitnessHist)
    t = mean(unlist(lapply(tmp, function(x) x$time)))
    optY = mean(unlist(lapply(tmp, function(x) x$optY)))
    fitnessHist = rowMeans(as.data.frame(lapply(tmp, function(x) x$fitnessHist)))
    convergedIter = length(fitnessHist) - which(abs(diff(rev(fitnessHist))) > 1e-5)[1]
    SArstByProbSize[[k]] = list(time = t, optY = optY, fitnessHist = fitnessHist, convergedIter = convergedIter)
  }
  
  
  
  
  tmp = list(MMrstByProbSize, GArstByProbSize, SArstByProbSize)
  MMGASAtime = lapply(tmp, function(x) unlist(lapply(x, function(y) y$time / length(y$fitnessHist) * y$convergedIter)))
  MMGASAoptY = lapply(tmp, function(x) unlist(lapply(x, function(y) y$optY)))
  MMGASAneval = lapply(tmp, function(x) unlist(lapply(x, function(y) y$convergedIter)))
  MMGASAneval[[1]] = MMGASAneval[[1]] * 200
  MMGASAneval[[2]] = MMGASAneval[[2]] * 200
  
  
  # time plot
  ylim = range(unlist(MMGASAtime))
  pdf("figure/MMGASAtime.pdf", width = 8, height = 8 * 0.618)
  par(mar = c(4.1, 5, 0, 0), family = "serif")
  tmp = MMGASAtime
  plot(0, col = "white", bty = "L", xlim = c(30, 80), ylim = ylim, cex.lab = 2, cex.axis = 1.5, xlab = "Problem size", ylab = "Time (s) till convergence")
  thecols = c("red", "blue", "darkgreen")
  legend("topleft", legend = c("MIMIC", "GA", "SA"), col = thecols, cex = 1.5, bty = "n", pch = c(15, 15, 15))
  for(i in 1:length(tmp))
  {
    lines(y = sort(tmp[[i]]), x = (3:8)*10, col = thecols[i], lwd = 2)
    lines(y = sort(tmp[[i]]), x = (3:8)*10, col = thecols[i], lwd = 2, type = "p", cex = 2)
  }
  dev.off()
  
  
  
  
  # Optimal value plot
  ylim = range(unlist(MMGASAoptY))
  pdf("figure/MMGASAoptY.pdf", width = 8, height = 8 * 0.618)
  par(mar = c(4.1, 5, 0, 0), family = "serif")
  tmp = MMGASAoptY
  plot(0, col = "white", bty = "L", xlim = c(30, 80), ylim = ylim, cex.lab = 2, cex.axis = 1.5, xlab = "Problem size", ylab = "Max fitness")
  thecols = c("red", "blue", "darkgreen")
  legend("topleft", legend = c("MIMIC", "GA", "SA"), col = thecols, cex = 1.5, bty = "n", pch = c(15, 15, 15))
  for(i in 1:length(tmp))
  {
    lines(y = sort(tmp[[i]]), x = (3:8)*10, col = thecols[i], lwd = 2)
    lines(y = sort(tmp[[i]]), x = (3:8)*10, col = thecols[i], lwd = 2, type = "p", cex = 2)
  }
  dev.off()
  

  
  
  # Function evaluations
  ylim = range(unlist(MMGASAneval))
  pdf("figure/MMGASAneval.pdf", width = 8, height = 8 * 0.618)
  par(mar = c(4.1, 5, 0, 0), family = "serif")
  tmp = MMGASAneval
  plot(0, col = "white", bty = "L", xlim = c(30, 80), ylim = ylim, cex.lab = 2, cex.axis = 1.5, xlab = "Problem size", ylab = "Function evaluations")
  thecols = c("red", "blue", "darkgreen")
  legend("topleft", legend = c("MIMIC", "GA", "SA"), col = thecols, cex = 1.5, bty = "n", pch = c(15, 15, 15))
  for(i in 1:length(tmp))
  {
    lines(y = sort(tmp[[i]]), x = (3:8)*10, col = thecols[i], lwd = 2)
    lines(y = sort(tmp[[i]]), x = (3:8)*10, col = thecols[i], lwd = 2, type = "p", cex = 2)
  }
  dev.off()
  
   
}

















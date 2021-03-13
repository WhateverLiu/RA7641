


# Process data.
if(F)
{
  dat = data.table::setDF(data.table::fread("data/digit.csv"))
  tmp = aggregate(list(ind = 1:nrow(dat)), list(dat$y), function(x) x)
  tmp[[2]] = lapply(tmp[[2]], function(x) sample(x))
  l = min(unlist(lapply(tmp[[2]], function(x) length(x))))
  tmp[[2]] = lapply(tmp[[2]], function(x) x[1:l])
  dat = dat[as.integer(t(as.data.frame(tmp[[2]]))), ]
  data.table::fwrite(dat, file = "data/digit.csv")
}




system(paste0("python GD.py Ntrn ", 30, " lrte ", 0.010, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 30, " lrte ", 0.020, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 30, " lrte ", 0.025, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 30, " lrte ", 0.030, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 30, " lrte ", 0.035, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 80, " lrte ", 0.0005, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 80, " lrte ", 0.001, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 80, " lrte ", 0.005, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 80, " lrte ", 0.010, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GD.py Ntrn ", 80, " lrte ", 0.015, " clmx ", 1, " mxit ", 100, " rsed ", 42), wait = F)




system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.05, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.1, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.15, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.2, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.25, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.30, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 30, " lrte ", 0.35, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)


system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.05, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.1, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.15, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.2, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.25, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.3, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python RH.py Ntrn ", 80, " lrte ", 0.35, " clmx ", 1, " mxit ", 10000, " rsed ", 42), wait = F)



system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.05, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.1, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.15, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.2, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.25, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.3, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 30, " lrte ", 0.35, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.05, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.1, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.15, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.2, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.25, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.3, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)
system(paste0("python SA.py Ntrn ", 80, " lrte ", 0.35, " clmx ", 1, " iniT ", 1, " Tdcy ", 0.05, " minT ", 0.001, " mxit ", 10000, " rsed ", 42), wait = F)









system(paste0("python GA.py Ntrn ", 30, " lrte ", 0.00001, " clmx ", 1, " popu ", 50, " mutP ", 0.1, " mxit ", 100, " rsed ", 42), wait = T)
system(paste0("python GA.py Ntrn ", 30, " lrte ", 0.05, " clmx ", 1, " popu ", 100, " mutP ", 0.5, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GA.py Ntrn ", 30, " lrte ", 0.05, " clmx ", 1, " popu ", 100, " mutP ", 0.5, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GA.py Ntrn ", 30, " lrte ", 0.05, " clmx ", 1, " popu ", 100, " mutP ", 0.5, " mxit ", 100, " rsed ", 42), wait = F)
system(paste0("python GA.py Ntrn ", 30, " lrte ", 0.05, " clmx ", 1, " popu ", 100, " mutP ", 0.5, " mxit ", 100, " rsed ", 42), wait = F)











































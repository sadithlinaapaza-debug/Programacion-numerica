# 8.7_features_temperatura.R
time <- 0:7
temp <- c(20.1,20.3,20.8,21.5,22.6,24.2,26.1,28.5)  # °C, cada segundo

n <- length(temp)

vel <- rep(NA, n)
acc <- rep(NA, n)
for (i in 1:n) {
  if (i==1) vel[i] <- (temp[i+1] - temp[i]) / (time[i+1] - time[i])
  else if (i==n) vel[i] <- (temp[i] - temp[i-1]) / (time[i] - time[i-1])
  else vel[i] <- (temp[i+1] - temp[i-1]) / (time[i+1] - time[i-1])
}
for (i in 2:(n-1)) {
  acc[i] <- (temp[i+1] - 2*temp[i] + temp[i-1]) / ((time[i+1]-time[i])^2)
}

features <- data.frame(time=time, temp=temp, vel=vel, acc=acc)
cat("1-2) Features (velocidad y aceleración):\n")
print(features)

alerts <- which(vel > 0.8)
cat("3) Alertas por vel > 0.8 °C/s en tiempos:\n")
if(length(alerts)>0) print(features[alerts,]) else cat("No hay alertas.\n")

min_max <- function(v) {
  if(all(is.na(v))) return(rep(NA,length(v)))
  (v - min(v, na.rm=TRUE)) / (max(v, na.rm=TRUE) - min(v, na.rm=TRUE))
}
features$vel_norm <- min_max(features$vel)
features$acc_norm <- min_max(features$acc)
cat("4) Features normalizadas (min-max):\n")
print(features)

cat("5) Justificación:\n")
cat(" - Velocidad y aceleración capturan cambios locales y patrones temporales que no aparecen en la señal cruda.\n")
cat(" - Para clasificación de anomalías, estas derivadas resaltan picos repentinos y cambios de tendencia, facilitando que modelos detecten eventos anómalos.\n")

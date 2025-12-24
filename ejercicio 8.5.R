# 8.5
hora <- 0:7
latency <- c(120,125,128,135,280,290,275,155)  

# diferencias 
forward <- function(y,i) if(i < length(y)) y[i+1] - y[i] else NA
backward <- function(y,i) if(i > 1) y[i] - y[i-1] else NA
central <- function(y,i) if(i>1 && i<length(y)) (y[i+1] - y[i-1]) / 2 else NA
second <- function(y,i) if(i>1 && i<length(y)) y[i+1] - 2*y[i] + y[i-1] else NA

# 1) primera derivada por hora 
first_deriv <- sapply(seq_along(latency), function(i) {
  if (i==1) forward(latency,i) else if (i==length(latency)) backward(latency,i) else central(latency,i)
})
cat("1) Primera derivada (ms/h) por hora:\n")
print(data.frame(hora=hora, latency=latency, d1=first_deriv))

# 2) identificar pico de anomalía
sec <- sapply(seq_along(latency), function(i) second(latency,i))
# buscar indices i where sec[i-1] > 0 and sec[i+1] < 0  (approx)
change_points <- c()
for (i in 3:(length(latency)-2)) {
  if (!is.na(sec[i-1]) && !is.na(sec[i+1])) {
    if (sec[i-1] > 0 && sec[i+1] < 0) change_points <- c(change_points, i)
  }
}
cat("2) Segunda derivada por hora (NA en extremos):\n"); print(sec)
if (length(change_points)>0) cat("Cambio de signo +->- alrededor de horas (indices):", paste(change_points, collapse=", "), "\n") else cat("No se detectó un claro +->- en vecinos inmediatos.\n")

# 3) magnitud salto brusco entre horas 3 y 4
jump_3_4 <- latency[5] - latency[4]   
cat("3) Salto entre hora 3 y 4: lat(h4)-lat(h3) =", jump_3_4, "ms\n")

# 4) A partir de hora 6, recuperación: tasa de recuperación 
i6 <- which(hora == 6)
recovery_rate <- if(i6 < length(latency)) (latency[i6+1] - latency[i6]) else NA
cat("4) Tasa de recuperación a partir de hora 6 (ms/h):", recovery_rate, "\n")

# 5) anomalía 
threshold <- 50
anoms <- which(abs(c(NA, diff(latency))) > threshold)  # diff gives change from i to i+1 at index i
# convert to hours where change occurs (between hora[i] and hora[i+1])
if (length(anoms) > 0) {
  cat("5) Anomalías detectadas entre horas:\n")
  for (a in anoms) cat(" entre", hora[a-1+1], "y", hora[a+1], " (cambio:", diff(latency)[a], "ms )\n")
} else cat("5) No se detectaron anomalías > 50 ms/hora\n")

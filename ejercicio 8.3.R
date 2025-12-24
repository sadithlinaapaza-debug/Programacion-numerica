# 8.3
dias <- c("Lun","Mar","Mie","Jue","Vie","Sab","Dom")
x <- 1:7
ventas <- c(45, 52, 61, 58, 73, 89, 95)  

# funciones 
forward_diff_v <- function(y, i, h=1) (y[i+h] - y[i]) / h
backward_diff_v <- function(y, i, h=1) (y[i] - y[i-h]) / h
central_diff_v <- function(y, i, h=1) (y[i+h] - y[i-h]) / (2*h)
second_diff_v <- function(y, i, h=1) (y[i+h] - 2*y[i] + y[i-h]) / (h^2)

# 1) velocidad para cada día
vel <- rep(NA, length(ventas))
for (i in 1:length(ventas)) {
  if (i == 1) vel[i] <- forward_diff_v(ventas, i)
  else if (i == length(ventas)) vel[i] <- backward_diff_v(ventas, i)
  else vel[i] <- central_diff_v(ventas, i)
}
cat("1) Velocidad (ventas) por día (miles $/día):\n")
print(data.frame(dia=dias, velocidad=vel))

# 2) día con mayor aceleración 
sec <- rep(NA, length(ventas))
for (i in 2:(length(ventas)-1)) sec[i] <- second_diff_v(ventas, i)
idx_max_sec <- which.max(sec, na.rm=TRUE)
cat("2) Mayor aceleración en:", dias[idx_max_sec], "con segunda derivada", sec[idx_max_sec], "\n")

# 3) El jueves hubo caída: magnitud de desaceleración
i <- 4
mag_desacel <- sec[i]
cat("3) Magnitud de la desaceleración (segunda derivada) en Jue:", mag_desacel, "miles $/día^2\n")

# 4) Extrapolación lineal:
slope_dom <- vel[length(vel)]
pred_lun <- ventas[length(ventas)] + slope_dom * 1  # 1 día ahead
cat("4) Predicción ventas Lunes siguiente (miles $):", pred_lun, "\n")

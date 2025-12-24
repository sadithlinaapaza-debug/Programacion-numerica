# 8.1
# Datos: meses y usuarios acumulados (miles)
mes  <- 1:7
users <- c(10, 15, 23, 34, 48, 65, 85)  # en miles

forward_diff <- function(y, x, i, h=1) (y[i + h] - y[i]) / (x[i + h] - x[i])
backward_diff <- function(y, x, i, h=1) (y[i] - y[i - h]) / (x[i] - x[i - h])
central_diff <- function(y, x, i, h=1) (y[i + h] - y[i - h]) / (x[i + h] - x[i - h])
second_diff <- function(y, x, i, h=1) (y[i + h] - 2*y[i] + y[i - h]) / ((x[i + h] - x[i])^2 / (h^2))

# 1) tasa de crecimiento 
i <- 4
growth_m4 <- central_diff(users, mes, i, h=1)   # en miles por mes
cat("1) Tasa de crecimiento en mes 4:", growth_m4, "miles/mes\n")

# 2) tasa en mes 1 
i <- 1
growth_m1 <- forward_diff(users, mes, i, h=1)
cat("2) Tasa de crecimiento en mes 1:", growth_m1, "miles/mes\n")

# 3) tasa en mes 7 
i <- 7
growth_m7 <- backward_diff(users, mes, i, h=1)
cat("3) Tasa de crecimiento en mes 7:", growth_m7, "miles/mes\n")

# 4) segunda derivada
sec <- rep(NA, length(users))
for (i in 2:(length(users)-1)) {
  sec[i] <- (users[i+1] - 2*users[i] + users[i-1]) / ( (mes[i+1] - mes[i])^2 )
}
cat("4) Segunda derivada por mes (NA en extremos):\n")
print(sec)

# ¿En qué mes fue mayor la aceleración?
idx_max_acc <- which.max(sec, na.rm=TRUE)
cat("Mayor aceleración en mes:", idx_max_acc, "con valor", sec[idx_max_acc], "miles/mes^2\n")

# 5) ¿acelerada o no?
cat("5) Interpretación: segunda derivada media (omit NA):", mean(sec, na.rm=TRUE), "\n")
if (mean(sec, na.rm=TRUE) > 0) cat("La startup está creciendo de forma acelerada en promedio.\n") else cat("Está desacelerándose en promedio.\n")

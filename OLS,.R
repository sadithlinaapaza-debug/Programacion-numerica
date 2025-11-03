# ------------------------------------------------------
# REGRESIÓN LINEAL: OLS vs DESCENSO DEL GRADIENTE (GD)
# ------------------------------------------------------

set.seed(123)  # Para reproducibilidad

n <- 1e6
x <- runif(n, 0, 10)
beta_0 <- 5
beta_1 <- 3
epsilon <- rnorm(n, mean = 0, sd = 2)
y <- beta_0 + beta_1 * x + epsilon

# ------------------------------------------------------
# MÉTODO 1: OLS (MÍNIMOS CUADRADOS ORDINARIOS)
# ------------------------------------------------------
cat("\n=== MÉTODO OLS ===\n")
tiempo_ols <- system.time({
  modelo_ols <- lm(y ~ x)
})
summary(modelo_ols)

cat("\n--- Resultados OLS ---\n")
cat("Beta_0 estimado:", coef(modelo_ols)[1], "\n")
cat("Beta_1 estimado:", coef(modelo_ols)[2], "\n")
cat("Tiempo de ejecución OLS (segundos):\n")
print(tiempo_ols)

# ------------------------------------------------------
# MÉTODO 2: DESCENSO DEL GRADIENTE
# ------------------------------------------------------
cat("\n=== MÉTODO GD ===\n")

# Hiperparámetros
alpha <- 0.000001     # tasa de aprendizaje
iteraciones <- 1000   # número de iteraciones

# Inicialización
b0 <- 0
b1 <- 0

tiempo_gd <- system.time({
  for (i in 1:iteraciones) {
    y_pred <- b0 + b1 * x
    grad_b0 <- (-2/n) * sum(y - y_pred)
    grad_b1 <- (-2/n) * sum(x * (y - y_pred))
    b0 <- b0 - alpha * grad_b0
    b1 <- b1 - alpha * grad_b1
  }
})

cat("\n--- Resultados GD ---\n")
cat("Beta_0 estimado:", b0, "\n")
cat("Beta_1 estimado:", b1, "\n")
cat("Tiempo de ejecución GD (segundos):\n")
print(tiempo_gd)

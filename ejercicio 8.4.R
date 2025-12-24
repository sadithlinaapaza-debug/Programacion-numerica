# 8.4
# Dato:
x <- c(-3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0)
sigma <- c(0.0474, 0.1192, 0.2689, 0.5000, 0.7311, 0.8808, 0.9526)

# funciones 
central_diff_vals <- function(y, i, h=1) {
  if (i <= 1 || i >= length(y)) return(NA)
  (y[i + h] - y[i - h]) / (2*h)
}

i0 <- which(x == 0.0)
sigma_prime_0_num <- central_diff_vals(sigma, i0, h=1)
cat("1) σ'(0) (num, centrada h=1):", sigma_prime_0_num, "\n")

i_m2 <- which(x == -2.0)
i_p2 <- which(x == 2.0)
sigma_prime_m2 <- central_diff_vals(sigma, i_m2, h=1)
sigma_prime_p2 <- central_diff_vals(sigma, i_p2, h=1)
cat("2) σ'(-2) num:", sigma_prime_m2, "  σ'(2) num:", sigma_prime_p2, "\n")

sigma_prime_analytic <- sigma * (1 - sigma)
cat("3) Comparación numérica vs analítica :\n")
comp <- data.frame(x=x, sigma=sigma, num_deriv=c(NA, sigma_prime_m2, NA, sigma_prime_0_num, NA, sigma_prime_p2, NA),
                   analytic = sigma_prime_analytic)
print(comp)

cat("Comparación en -2:\n num=", sigma_prime_m2, " analytic=", sigma_prime_analytic[i_m2], "\n")
cat("Comparación en 0:\n num=", sigma_prime_0_num, " analytic=", sigma_prime_analytic[i0], "\n")
cat("Comparación en 2:\n num=", sigma_prime_p2, " analytic=", sigma_prime_analytic[i_p2], "\n")

cat("4) Recomendación: usar h pequeño (ej. 0.1 o 0.01) si puedes evaluar σ(x) con mayor resolución.\n")
cat("Razon: centrada reduce error O(h^2); con h=1 la aproximación es cruda porque los puntos están separados.\n")

# 5) ¿Por qué derivada es simétrica alrededor de 0?
cat("5) La sigmoide es simétrica (anti-impar) respecto a x=0 en su pendiente: σ(-x)=1-σ(x),\n")
cat("    lo que hace que σ'(x) sea par (simétrica): σ'(-x) = σ'(x).\n")

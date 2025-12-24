# 8.2
# Epocas y loss
epoch <- c(0,10,20,30,40,50)
loss  <- c(2.45, 1.82, 1.35, 1.08, 0.95, 0.89)

h <- 10

idx_of <- function(e) which(epoch == e)

# 1) tasa de cambio 
i20 <- idx_of(20)
# centrada: (loss(epoch+h) - loss(epoch-h)) / (2*h)
d_loss_20 <- (loss[i20 + 1] - loss[i20 - 1]) / (2*h)
cat("1) Tasa de cambio (centrada) en epoca 20:", d_loss_20, "loss/epoca\n")

# 2) segunda derivada 
i30 <- idx_of(30)

sec_loss_30 <- (loss[i30+1] - 2*loss[i30] + loss[i30-1]) / (h^2)
cat("2) Segunda derivada en epoca 30:", sec_loss_30, " (si >0 => convexidad positiva)\n")
if (sec_loss_30 < 0) cat("Indica que la curvatura es cóncava hacia abajo: desaceleración en la caída del loss (puede indicar acercamiento a mínimo).\n")

# 3) ¿En qué epoca la tasa de cambio < 0.01 por epoca?
d_rates <- rep(NA, length(epoch))
for (i in 2:(length(epoch)-1)) {
  d_rates[i] <- (loss[i+1] - loss[i-1]) / (2*(epoch[i+1]-epoch[i-1])/2)  
}
d_rates[1] <- (loss[2] - loss[1]) / (epoch[2] - epoch[1])
d_rates[length(epoch)] <- (loss[length(epoch)] - loss[length(epoch)-1]) / (epoch[length(epoch)] - epoch[length(epoch)-1])

cat("3) Tasa de cambio por epoca (approx):\n")
for (i in seq_along(epoch)) cat(" epoch", epoch[i], " -> rate:", d_rates[i], "\n")

epochs_below_001 <- epoch[which(abs(d_rates) < 0.01)]
cat("Épocas donde |tasa| < 0.01:", if(length(epochs_below_001)>0) paste(epochs_below_001, collapse=", ") else "ninguna", "\n")

# 4) Estimar loss en epoca 25 usando interpolación lineal basada en derivadas
dL_at_20 <- d_loss_20
L25_by_deriv <- loss[i20] + (25 - 20) * dL_at_20
cat("4) Estimación L(25) usando derivada en 20:", L25_by_deriv, "\n")

L20 <- loss[i20]; L30 <- loss[i20+1]
L25_linear <- L20 + (25-20) * (L30 - L20)/(30-20)
cat("Estimación L(25) por interpolación lineal entre 20 y 30:", L25_linear, "\n")

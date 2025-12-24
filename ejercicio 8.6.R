# 8.6
gasto <- c(0,5,10,15,20,25)  
conv  <- c(2.1, 3.8, 5.2, 6.1, 6.7, 7.0)  

h <- 5

roi_marginal_per5k <- rep(NA, length(conv))
for (i in 2:(length(conv)-1)) {
  roi_marginal_per5k[i] <- (conv[i+1] - conv[i-1]) / (gasto[i+1] - gasto[i-1])  # % per k$
}
roi_marginal_per5k[1] <- (conv[2] - conv[1]) / (gasto[2] - gasto[1])
roi_marginal_per5k[length(conv)] <- (conv[length(conv)] - conv[length(conv)-1]) / (gasto[length(gasto)] - gasto[length(gasto)-1])

cat("1) ROI marginal (% por $1k) en cada punto:\n")
print(data.frame(gasto=gasto, conversion=conv, roi_marginal_pct_per_k=roi_marginal_per5k))

idx_gt_02 <- which(roi_marginal_per5k > 0.2)
cat("2) Rangos donde ROI marginal > 0.2%/k$ ocurren en índices:", idx_gt_02, "\n")
if (length(idx_gt_02)>0) print(data.frame(gasto=gasto[idx_gt_02], roi=roi_marginal_per5k[idx_gt_02]))

i15 <- which(gasto == 15)
sec_at_15 <- (conv[i15+1] - 2*conv[i15] + conv[i15-1]) / ((gasto[i15+1] - gasto[i15])^2)
cat("3) Segunda derivada en $15k:", sec_at_15, " (% per (k$)^2 )\n")

cat("4) Interpretación: si segunda derivada negativa => rendimientos decrecientes.\n")
cat("En nuestros datos la ROI marginal en 25k es:", roi_marginal_per5k[length(roi_marginal_per5k)], "\n")
cat("Como la ROI marginal cae (y segunda derivada tiende a ser negativa), matemáticamente no es rentable aumentar indefinidamente más allá de 25k salvo que haya objetivos no marginales.\n")

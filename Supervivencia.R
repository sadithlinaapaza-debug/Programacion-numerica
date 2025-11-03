tipos <- c("A", "B", "C")

caramelos_aleatorios <- function(n) sample(tipos, n, replace = TRUE)

set.seed(123)  
caramelos_grupo <- caramelos_aleatorios(9 * 2)  
chupetines <- 0
objetivo <- 9  

cat(" Caramelos iniciales:", paste(caramelos_grupo, collapse = " "), "\n")

# Regla 2: 2A + 2B + 2C → 2 chupetines + 1 caramelo aleatorio
regla2 <- function(caramelos, chupetines) {
  aplicado <- FALSE
  while (sum(caramelos == "A") >= 2 &&
         sum(caramelos == "B") >= 2 &&
         sum(caramelos == "C") >= 2) {
    for (x in c("A", "B", "C")) {
      caramelos <- caramelos[-which(caramelos == x)[1:2]]
    }
    chupetines <- chupetines + 2
    caramelos <- c(caramelos, sample(tipos, 1))
    aplicado <- TRUE
    cat("Regla 2 aplicada → +2 chupetines, +1 caramelo aleatorio\n")
  }
  return(list(caramelos, chupetines, aplicado))
}

# Regla 3: 1 chupetín → 3 caramelos aleatorios
regla3 <- function(caramelos, chupetines) {
  if (chupetines >= 2) {  # solo si tienen al menos 2 chupetines
    chupetines <- chupetines - 1
    nuevos <- sample(tipos, 3, replace = TRUE)
    caramelos <- c(caramelos, nuevos)
    cat("Regla 3 aplicada → 1 chupetín cambiado por:", paste(nuevos, collapse = " "), "\n")
  }
  return(list(caramelos, chupetines))
}

# Regla 1: A + B + C → 1 chupetín
regla1 <- function(caramelos, chupetines) {
  aplicado <- FALSE
  while (all(c("A", "B", "C") %in% caramelos)) {
    caramelos <- caramelos[-match(c("A", "B", "C"), caramelos)]
    chupetines <- chupetines + 1
    aplicado <- TRUE
    cat("Regla 1 aplicada → +1 chupetín (combinación A+B+C)\n")
  }
  return(list(caramelos, chupetines, aplicado))
}

iter <- 0

repeat {
  iter <- iter + 1
  cat("\nIteración", iter, "\n")
  cat("Caramelos:", paste(caramelos_grupo, collapse = " "), 
      "- Chupetines:", chupetines, "\n")
  
  res2 <- regla2(caramelos_grupo, chupetines)
  caramelos_grupo <- res2[[1]]
  chupetines <- res2[[2]]
  
  if (chupetines >= 2 && chupetines < objetivo) {
    res3 <- regla3(caramelos_grupo, chupetines)
    caramelos_grupo <- res3[[1]]
    chupetines <- res3[[2]]
  }
  
  if (chupetines >= 8 && chupetines < objetivo) {
    res1 <- regla1(caramelos_grupo, chupetines)
    caramelos_grupo <- res1[[1]]
    chupetines <- res1[[2]]
  }
  
  # Mostrar progreso
  cat("Estado tras la iteración:", chupetines, "chupetines,",
      length(caramelos_grupo), "caramelos.\n")
  
  if (chupetines >= objetivo) {
    cat("\nEl grupo logró obtener los 9 chupetines en", iter, "iteraciones\n")
    break
  }
 
  if (iter > 200) {
    cat("\nNo se logró el objetivo después de 200 iteraciones.\n")
    break
  }
}

 #METODO DE GRADIENTE
> f <- function(x){x^2}
> f_deriv <- function(x){2*x} 
> #Parametro
> x0 <- 3 
> n <- 0.01       #n = tasa de aprendizaje
> max_iter <- 100
> #Iteraciones
> for(i in 1:max_iter){
+ x_nuevo <- x0 - (n * f_deriv(x0)
+ x0 <- x_nuevo
Error: unexpected symbol in:
"x_nuevo <- x0 - (n * f_deriv(x0)
x0"
> }
Error: inesperado '}' en "}"
>  #METODO DE GRADIENTE
> f <- function(x){x^2}
> f_deriv <- function(x){2*x} 
> #Parametro
> x0 <- 3
> n <- 0.01       #n = tasa de aprendizaje
+ 
> max_iter <- 100
> #Iteraciones
> for(i in 1:max_iter){
+ x_nuevo <- x0 - (n * f_deriv(x0))
+ x0 <- x_nuevo}
> #Resultado Final
> cat("convergio en ",i,"iteraciones\n")
convergio en  100 iteraciones
> cat("El minimo esta en x = ",x0,"\n")
El minimo esta en x =  0.3978587 
> cat("El valor minimo esta en f(x)=",f(x),"\n")
El valor minimo esta en f(x)= 8.999972 
> cat("la derivada de x es ",f_deriv,"\n")
la derivada de x es  Error en cat("la derivada de x es ", f_deriv, "\n"): 
  el argumento 2 (type 'closure') no es soportado por 'cat'
> cat("la derivada de x es ",f_deriv(x0),"\n")
la derivada de x es  0.7957173 
> cat("El valor minimo esta en f(x)=",f(x0),"\n")
El valor minimo esta en f(x)= 0.1582915 
> 

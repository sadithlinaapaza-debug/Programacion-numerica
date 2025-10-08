import math

class PuntoFijo:
    def __init__(self):
        pass

    def g(self, x, expr):
        safe_locals = {
            "x": x,
            "ln": math.log,        
            "log": math.log,       
            "log10": math.log10,   
            "exp": math.exp,
            "sqrt": math.sqrt,
            "e": math.e,
            "pi": math.pi,
            **{k: getattr(math, k) for k in dir(math) if not k.startswith("__")}
        }
        return eval(expr, {"__builtins__": None}, safe_locals)

    def ejecutar(self):
        expr = input("Ingrese g(x): ").strip()
        x0 = float(input("x0: "))
        tol = float(input("Tolerancia (ej: 1e-6): "))
        maxit = int(input("Iteraciones maximas: "))
        x = x0
        for i in range(1, maxit+1):
            x_new = self.g(x, expr)
            if abs(x_new - x) < tol:
                print(f"Punto fijo: {x_new}")
                print(f"Iteraciones: {i}")
                return
            x = x_new
        print(f"Resultado tras {maxit} iter: {x}")
        print(f"g(aprox): {self.g(x, expr)}")

if __name__ == "__main__":
    PuntoFijo().ejecutar()

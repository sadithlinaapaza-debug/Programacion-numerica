import math

class Secante:
    def __init__(self):
        pass

    def f(self, x, expr):
        return eval(expr, {"__builtins__":None}, {"x":x, **math.__dict__})

    def ejecutar(self):
        expr = input("Ingrese f(x) : ").strip()
        x0 = float(input("x0: "))
        x1 = float(input("x1: "))
        tol = float(input("Tolerancia (ej: 1e-6): "))
        maxit = int(input("Iteraciones maximas: "))
        f0 = self.f(x0, expr)
        f1 = self.f(x1, expr)
        for i in range(1, maxit+1):
            denom = (f1 - f0)
            if denom == 0:
                print("Denominador cero. Deteniendo.")
                return
            x2 = x1 - f1 * (x1 - x0) / denom
            if abs(x2 - x1) < tol:
                print(f"Raíz: {x2}")
                print(f"f(raíz): {self.f(x2, expr)}")
                print(f"Iteraciones: {i}")
                return
            x0, f0 = x1, f1
            x1, f1 = x2, self.f(x2, expr)
        print(f"Resultado tras {maxit} iter: {x1}")
        print(f"f(aprox): {self.f(x1, expr)}")

if __name__ == "__main__":
    Secante().ejecutar()


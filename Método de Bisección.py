import math

class Biseccion:
    def __init__(self):
        pass

    def f(self, x, expr):
        return eval(expr, {"__builtins__":None}, {"x":x, **math.__dict__})

    def ejecutar(self):
        expr = input("Ingrese f(x) como expresión en Python : ").strip()
        a = float(input("a: "))
        b = float(input("b: "))
        tol = float(input("Tolerancia (ej: 1e-6): "))
        maxit = int(input("Iteraciones maximas: "))
        fa = self.f(a, expr)
        fb = self.f(b, expr)
        if fa * fb > 0:
            print("No hay cambio de signo en el intervalo.")
            return
        for i in range(1, maxit+1):
            c = (a + b) / 2.0
            fc = self.f(c, expr)
            if abs(fc) == 0 or (b - a) / 2.0 < tol:
                print(f"Raíz: {c}")
                print(f"f(raíz): {fc}")
                print(f"Iteraciones: {i}")
                return
            if fa * fc < 0:
                b = c
                fb = fc
            else:
                a = c
                fa = fc
        print(f"Raíz aproximada tras {maxit} iter: {c}")
        print(f"f(raíz): {fc}")

if __name__ == "__main__":
    Biseccion().ejecutar()


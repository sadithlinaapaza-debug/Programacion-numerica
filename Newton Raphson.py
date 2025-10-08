import math

class NewtonRaphson:
    def __init__(self):
        pass

    def f(self, x, expr):
        return eval(expr, {"__builtins__":None}, {"x":x, **math.__dict__})

    def ejecutar(self):
        expr = input("Ingrese f(x): ").strip()
        dexpr = input("Ingrese f'(x): ").strip()
        x0 = float(input("x0: "))
        tol = float(input("Tolerancia (ej: 1e-6): "))
        maxit = int(input("Iteraciones maximas: "))
        x = x0
        for i in range(1, maxit+1):
            fx = self.f(x, expr)
            dfx = self.f(x, dexpr)
            if dfx == 0:
                print("Derivada cero. Deteniendo.")
                return
            x_new = x - fx/dfx
            if abs(x_new - x) < tol:
                print(f"Raíz: {x_new}")
                print(f"f(raíz): {self.f(x_new, expr)}")
                print(f"Iteraciones: {i}")
                return
            x = x_new
        print(f"Resultado tras {maxit} iter: {x}")
        print(f"f(aprox): {self.f(x, expr)}")

if __name__ == "__main__":
    NewtonRaphson().ejecutar()

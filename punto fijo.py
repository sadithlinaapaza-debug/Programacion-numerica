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
        expr = input("Ingrese g(x) para x = g(x) : ").strip()
        x0 = float(input("x0: "))
        tol = float(input("Tolerancia (ej: 1e-6): "))
        maxit = int(input("Iteraciones máximas: "))

        x = x0
        for i in range(1, maxit + 1):
            x_new = self.g(x, expr)
            error = abs((x_new - x) / x_new) * 100 if x_new != 0 else float('inf')

            print(f"Iteración {i}: x = {x_new:.10f}, Error = {error:.6f}%")

            if error < tol * 100:  
                print(f"\nPunto fijo: {x_new}")
                print(f"Iteraciones: {i}")
                print(f"Error porcentual final: {error:.6f}%")
                return

            x = x_new

        print(f"\nResultado tras {maxit} iteraciones: {x}")
        print(f"Error porcentual final: {error:.6f}%")

if __name__ == "__main__":
    PuntoFijo().ejecutar()


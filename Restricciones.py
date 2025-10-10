class Restriccion:
    def __init__(self, expresion):
        self.expresion = expresion.replace(" ", "")

    def cumple(self, x, y):
        expr = self.expresion.replace("x", str(x)).replace("y", str(y))
        try:
            return eval(expr)
        except Exception as e:
            print("Error evaluando la restricción:", self.expresion, "->", e)
            return False

class ProblemaASCII:
    def __init__(self):
        self.restricciones = []

    def ingresar_datos(self):
        n = int(input("¿Cuántas restricciones?: ").strip())
        for i in range(n):
            r = input(f"Restricción #{i+1}: ")
            self.restricciones.append(Restriccion(r))

        print("\n--- RANGOS ---")
        self.x_min = int(input("x mínimo : ").strip())
        self.x_max = int(input("x máximo : ").strip())
        self.y_min = int(input("y mínimo : ").strip())
        self.y_max = int(input("y máximo : ").strip())

        paso = input("Paso de la cuadrícula (enteros, por defecto 1): ").strip()
        self.step = int(paso) if paso != "" else 1

    def punto_factible(self, x, y):
        for r in self.restricciones:
            if not r.cumple(x, y):
                return False
        return True

    def listar_puntos_factibles(self):
        factibles = []
        for y in range(self.y_min, self.y_max + 1, self.step):
            for x in range(self.x_min, self.x_max + 1, self.step):
                if self.punto_factible(x, y):
                    factibles.append((x, y))
        return factibles

    def imprimir_ascii(self):
        xs = list(range(self.x_min, self.x_max + 1, self.step))
        ys = list(range(self.y_min, self.y_max + 1, self.step))

        print("\n=== GRÁFICA  ===")
        header = "    " 
        for x in xs:
            if (x - self.x_min) % (max(1, (len(xs)//10))) == 0:
                header += f"{str(x).rjust(2)}"
            else:
                header += "  "
        print(header)

        for y in reversed(ys): 
            line = f"{str(y).rjust(3)} "  
            for x in xs:
                if self.punto_factible(x, y):
                    line += " #"
                else:
                    line += " ."
            print(line)

        footer = "    "
        for x in xs:
            if (x - self.x_min) % (max(1, (len(xs)//10))) == 0:
                footer += f"{str(x).rjust(2)}"
            else:
                footer += "  "
        print(footer)
        print("\nLeyenda: '#' punto factible, '.' no factible.")

    def ejecutar(self):
        self.ingresar_datos()
        factibles = self.listar_puntos_factibles()
        if not factibles:
            print("\nNo se encontraron puntos factibles en el rango dado.")
        else:
            print(f"\nSe encontraron {len(factibles)} puntos factibles:")
            for p in factibles[:20]:
                print(" ", p)
        self.imprimir_ascii()

def main():
    prog = ProblemaASCII()
    prog.ejecutar()

if __name__ == "__main__":
    main()

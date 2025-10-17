class GraficadoraLineal:
    def __init__(self, expresion1, expresion2):
        self.expresion1 = expresion1
        self.expresion2 = expresion2
        self.x = []
        self.y1 = []
        self.y2 = []

    def generar_valores(self):
        x = -10
        while x <= 10:
            self.x.append(x)
            self.y1.append(eval(self.expresion1))
            self.y2.append(eval(self.expresion2))
            x = x + 1

    def graficar_consola(self):
        for i in range(len(self.x)):
            espacios1 = " " * (self.y1[i] + 20)
            linea = f"x={self.x[i]:>3} | {espacios1}*"

            espacios2 = " " * (self.y2[i] + 20)
            linea2 = f"{espacios2}#"

            print(linea + linea2)

f1 = input("Ingresa la primera funcion lineal: ")
f2 = input("Ingresa la segunda funcion lineal: ")

mi_grafica = GraficadoraLineal(f1, f2)
mi_grafica.generar_valores()
mi_grafica.graficar_consola()

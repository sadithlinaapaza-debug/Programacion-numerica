class Analizador:
    def __init__(self, funcion):
        self.funcion = funcion

    def obtener_variables(self):
        variables = []
        for caracter in self.funcion:
            if caracter.isalpha() and caracter not in variables:
                variables.append(caracter)
        return variables

    def obtener_operaciones(self):
        operaciones = []
        for caracter in self.funcion:
            if caracter in "+-*/":
                operaciones.append(caracter)
        return operaciones

funcion = input("Escribe una función matemática: ")

analizador = Analizador(funcion)

print("\n RESULTADO ")
print("Variables encontradas:", analizador.obtener_variables())
print("Operaciones encontradas:", analizador.obtener_operaciones())

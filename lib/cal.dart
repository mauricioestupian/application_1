import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  // ESTADO

  String expresion = "";

  String resultado = "0";

  double numero1 = 0;

  double numero2 = 0;

  String operacion = "";

  // LOGICA

  void presionarBoton(String valor) {
    setState(() {
      switch (valor) {
        case "C":
          expresion = "";
          resultado = "0";
          numero1 = 0;
          numero2 = 0;
          operacion = "";

          break;

        case "+":
        case "-":
        case "*":
        case "/":
          numero1 = double.parse(resultado);

          operacion = valor;

          expresion = "$resultado $valor";

          resultado = "0";

          break;

        case "=":
          numero2 = double.parse(resultado);

          double r = calcular();

          expresion = "$numero1 $operacion $numero2 =";

          resultado = r.toString();

          break;

        default:
          if (resultado == "0") {
            resultado = valor;
          } else {
            resultado += valor;
          }
      }
    });
  }

  double calcular() {
    switch (operacion) {
      case "+":
        return numero1 + numero2;

      case "-":
        return numero1 - numero2;

      case "*":
        return numero1 * numero2;

      case "/":
        return numero1 / numero2;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),

      body: SafeArea(
        child: Column(
          children: [
            // DISPLAY
            Expanded(
              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(30),

                alignment: Alignment.bottomRight,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text(
                      expresion,

                      style: const TextStyle(color: Colors.grey, fontSize: 28),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      resultado,

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTONES
            Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                children: [
                  fila("7", "8", "9", "/"),

                  fila("4", "5", "6", "*"),

                  fila("1", "2", "3", "-"),

                  fila("0", "C", "=", "+"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FILAS

  Widget fila(String b1, String b2, String b3, String b4) {
    return Row(children: [boton(b1), boton(b2), boton(b3), boton(b4)]);
  }

  // BOTON REUTILIZABLE

  Widget boton(String texto) {
    bool operador =
        texto == "+" ||
        texto == "-" ||
        texto == "*" ||
        texto == "/" ||
        texto == "=";

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: operador ? Colors.orange : const Color(0xff2d2d2d),

            foregroundColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),

            padding: const EdgeInsets.all(22),

            elevation: 8,
          ),

          onPressed: () {
            presionarBoton(texto);
          },

          child: Text(
            texto,

            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

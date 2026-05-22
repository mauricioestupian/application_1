import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Columas en Flutter')),

        body: Center(
          // Contenedor principal
          child: Container(
            // Tamaño del contenedor
            width: 350,
            height: 200,

            // Espacio interno
            padding: const EdgeInsets.all(20),

            // Estilo del contenedor
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),

            // Filas
            child: Row(
              // Espacio entre columnas
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                // COLUMNA 1
                Column(
                  // Centra verticalmente
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Hijos
                  children: const [
                    //Hijo 1
                    Icon(Icons.person, size: 40),
                    SizedBox(height: 10),
                    Text('Usuario', style: TextStyle(fontSize: 20)),
                  ],
                ),

                // COLUMNA 2
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: const [
                    //Hijo 2
                    Icon(Icons.phone, size: 40),
                    SizedBox(height: 10),
                    Text('Telefono', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

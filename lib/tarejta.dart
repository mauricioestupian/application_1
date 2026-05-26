import 'package:flutter/material.dart';

class Tarjeta extends StatelessWidget {
  const Tarjeta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Tarjeta Información')),

        body: Center(
          // Contenedor principal
          child: Container(
            // Ancho de la tarjeta
            width: 350,

            // Espacio interno
            padding: const EdgeInsets.all(20),

            // Diseño visual
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 208, 227, 84),

              borderRadius: BorderRadius.circular(20),

              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Colors.black12),
              ],
            ),

            // Organiza horizontalmente
            child: Row(
              children: [
                // ICONO USUARIO
                const Icon(Icons.person, size: 80, color: Colors.blue),

                const SizedBox(width: 20),

                // INFORMACIÓN
                Column(
                  // Ajusta tamaño al contenido
                  mainAxisSize: MainAxisSize.min,

                  // Alinea a la izquierda
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [
                    // Nombre
                    Text(
                      'Juan Pérez',

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    // Correo
                    Row(
                      children: [
                        Icon(Icons.email, size: 18),

                        SizedBox(width: 10),

                        Text('juan@gmail.com', style: TextStyle(fontSize: 16)),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Teléfono
                    Row(
                      children: [
                        Icon(Icons.phone, size: 18),

                        SizedBox(width: 10),

                        Text('3001234567', style: TextStyle(fontSize: 16)),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Ciudad
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 18),

                        SizedBox(width: 10),

                        Text('Bogotá', style: TextStyle(fontSize: 16)),
                      ],
                    ),
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

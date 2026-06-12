import 'package:flutter/material.dart';

import 'login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("VetCare"),
        centerTitle: true,
        backgroundColor: const Color(0xFF00A86B),
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            tooltip: "Cerrar sesión",

            onPressed: () async {
              bool? salir = await showDialog(
                context: context,

                builder: (context) {
                  return AlertDialog(
                    title: const Text("Cerrar sesión"),

                    content: const Text("¿Desea cerrar la sesión?"),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },

                        child: const Text("Cancelar"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },

                        child: const Text("Salir"),
                      ),
                    ],
                  );
                },
              );

              if (salir == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              }
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // SALUDO
            const Text(
              "Bienvenido 👋",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "Sistema de Gestión Veterinaria",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 25),

            // TARJETAS DE RESUMEN
            Row(
              children: [
                Expanded(child: tarjetaResumen("Mascotas", "125", Icons.pets)),

                const SizedBox(width: 10),

                Expanded(
                  child: tarjetaResumen(
                    "Consultas",
                    "42",
                    Icons.medical_services,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: tarjetaResumen("Citas", "15", Icons.calendar_month),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: tarjetaResumen("Vacunas", "68", Icons.vaccines),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Accesos rápidos",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,

              crossAxisSpacing: 10,

              mainAxisSpacing: 10,

              children: [
                menuCard("Mascotas", Icons.pets, Colors.blue),

                menuCard("Citas", Icons.calendar_today, Colors.orange),

                menuCard("Vacunas", Icons.vaccines, Colors.green),

                menuCard("Veterinarios", Icons.person, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tarjetaResumen(String titulo, String cantidad, IconData icono) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            Icon(icono, size: 40, color: const Color(0xFF00A86B)),

            const SizedBox(height: 10),

            Text(
              cantidad,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            Text(titulo),
          ],
        ),
      ),
    );
  }

  Widget menuCard(String titulo, IconData icono, Color color) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: InkWell(
        borderRadius: BorderRadius.circular(15),

        onTap: () {},

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icono, size: 50, color: color),

            const SizedBox(height: 10),

            Text(
              titulo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

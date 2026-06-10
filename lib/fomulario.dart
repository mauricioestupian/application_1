import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final nombreController = TextEditingController();

  final correoController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: correoController,
              decoration: const InputDecoration(labelText: "Correo"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: () {}, child: const Text("Registrar")),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistroUsuario(),
    );
  }
}

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  // KEY DEL FORMULARIO
  final _formKey = GlobalKey<FormState>();

  // CONTROLADORES
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Profesional'),
        backgroundColor: Colors.indigo,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              const Icon(
                Icons.account_circle,
                size: 120,
                color: Color.fromARGB(255, 141, 230, 40),
              ),

              const SizedBox(height: 20),

              const Text(
                'Registro de Usuario',

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // NOMBRE
              TextFormField(
                controller: nombreController,

                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),
              // EMAIL
              TextFormField(
                controller: emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 20),
              // TELEFONO
              TextFormField(
                controller: phoneController,

                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(
                  labelText: 'Número de Teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

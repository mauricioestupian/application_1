import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('es', 'ES'),
      supportedLocales: [Locale('es', 'ES')],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
  final passwordController = TextEditingController();

  //variables del sistema
  String rol = 'Usuario';
  DateTime? fechaNacimiento;

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
              const SizedBox(height: 20),
              // CONTRASEÑA
              TextFormField(
                controller: passwordController,

                obscureText: true,

                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: rol,

                decoration: const InputDecoration(
                  labelText: 'Rol',
                  border: OutlineInputBorder(),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'Usuario',
                    child: Text('Usuariosssss'),
                  ),
                  DropdownMenuItem(
                    value: 'Administrador',
                    child: Text('Administrador'),
                  ),
                  DropdownMenuItem(value: 'Cliente', child: Text('Cliente')),
                ],
                onChanged: (value) {
                  setState(() {
                    rol = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double
                    .infinity, //espacio horizontal completo automáticamente

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calendar_month),

                  label: Text(
                    fechaNacimiento == null
                        ? 'Seleccionar Fecha de Nacimiento'
                        : 'Fecha: ${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}',
                  ),

                  onPressed: () async {
                    DateTime? fecha = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2027),
                    );

                    if (fecha != null) {
                      setState(() {
                        fechaNacimiento = fecha;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

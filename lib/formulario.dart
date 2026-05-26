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
  final correoController = TextEditingController();
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final passwordController = TextEditingController();

  // VARIABLES DE ESTADO
  String rol = 'Usuario';

  bool aceptaTerminos = false;

  bool notificaciones = true;

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
              const Icon(Icons.account_circle, size: 120, color: Colors.indigo),

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

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // CORREO
              TextFormField(
                controller: correoController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),

                validator: (value) {
                  if (value == null || !value.contains("@")) {
                    return 'Correo inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // TELEFONO
              TextFormField(
                controller: telefonoController,

                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD
              TextFormField(
                controller: passwordController,

                obscureText: true,

                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),

                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Mínimo 6 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // DROPDOWN
              DropdownButtonFormField(
                value: rol,

                decoration: const InputDecoration(
                  labelText: 'Rol',
                  border: OutlineInputBorder(),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'Administrador',
                    child: Text('Administrador'),
                  ),

                  DropdownMenuItem(value: 'Usuario', child: Text('Usuario')),

                  DropdownMenuItem(value: 'Cliente', child: Text('Cliente')),
                ],

                onChanged: (value) {
                  setState(() {
                    rol = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // FECHA
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calendar_month),

                  label: Text(
                    fechaNacimiento == null
                        ? 'Seleccionar fecha'
                        : '${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}',
                  ),

                  onPressed: () async {
                    DateTime? fecha = await showDatePicker(
                      context: context,

                      initialDate: DateTime.now(),

                      firstDate: DateTime(1950),

                      lastDate: DateTime.now(),
                    );

                    if (fecha != null) {
                      setState(() {
                        fechaNacimiento = fecha;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),

              // SWITCH
              SwitchListTile(
                title: const Text('Recibir notificaciones'),

                value: notificaciones,

                onChanged: (value) {
                  setState(() {
                    notificaciones = value;
                  });
                },
              ),

              // CHECKBOX
              CheckboxListTile(
                title: const Text('Acepto términos y condiciones'),

                value: aceptaTerminos,

                onChanged: (value) {
                  setState(() {
                    aceptaTerminos = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && aceptaTerminos) {
                      print("FORMULARIO VALIDO");

                      print(nombreController.text);
                      print(correoController.text);
                      print(rol);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Complete correctamente el formulario'),
                        ),
                      );
                    }
                  },

                  child: const Text(
                    'REGISTRAR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

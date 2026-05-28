import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool aceptaTerminos = false;
  bool notificaciones = false;

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

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu correo electrónico';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, ingresa un correo electrónico válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              // TELEFONO
              TextFormField(
                controller: phoneController,

                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Solo permite números
                ],

                decoration: const InputDecoration(
                  labelText: 'Número de Teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu número de teléfono';
                  }
                  if (value.length < 7) {
                    return 'El número de teléfono debe tener al menos 7 dígitos';
                  }
                  return null;
                },
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

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
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

              //Calendario
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

              const SizedBox(height: 30),

              //checkbox para terminos y condiciones
              CheckboxListTile(
                title: const Text('Acepto los términos y condiciones'),

                value: aceptaTerminos,
                onChanged: (value) {
                  setState(() {
                    aceptaTerminos =
                        value!; // actualizar el estado del checkbox
                  });
                },
              ),
              const SizedBox(height: 10),

              //switch para recibir notificaciones
              SwitchListTile(
                title: const Text('Recibir notificaciones'),
                value: notificaciones,
                onChanged: (value) {
                  setState(() {
                    notificaciones = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              // BOTON DE REGISTRO
              SizedBox(
                width: double
                    .infinity, //espacio horizontal completo automáticamente
                height: 50, //altura fija para el botón
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para validar el formulario y registrar al usuario
                    if (_formKey.currentState!.validate() && aceptaTerminos) {
                      print("Formaulario válido. Procesar registro...");

                      print("Nombre: ${nombreController.text}");
                    } else {
                      print(
                        "Por favor, complete el formulario y acepte los términos.",
                      );
                    }
                  },
                  child: const Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

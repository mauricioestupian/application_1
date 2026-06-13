import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'widget/inputtext.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  // Llave del formulario para ejecutar validaciones
  final formKey = GlobalKey<FormState>();

  // Controladores de los campos
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();

  final documentoController = TextEditingController();
  String tipoDocumento = "";
  final tiposDocumento = [
    {"value": "", "label": "Seleccione..."},
    {"value": "CC", "label": "Cédula de Ciudadanía"},
    {"value": "CE", "label": "Cédula de Extranjería"},
    {"value": "PA", "label": "Pasaporte"},
    {"value": "TI", "label": "Tarjeta de Identidad"},
  ];

  final calleController = TextEditingController();
  final ciudadController = TextEditingController();
  final paisController = TextEditingController();
  final codigoPostalController = TextEditingController();

  final emailController = TextEditingController();
  final usuarioController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        // Flutter agrega automáticamente el botón de retroceso
        title: const Text("Registro"),

        backgroundColor: const Color(0xFF00A86B),

        foregroundColor: Colors.white,
      ),

      // Color de fondo de la pantalla
      backgroundColor: const Color(0xFFF5F7FA),

      body: SingleChildScrollView(
        // Evita desbordamiento cuando aparecen muchos campos
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 10),

            // LOGO DE LA VETERINARIA
            // ===============================
            Container(
              width: 130,
              height: 130,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(65),

                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(65),

                child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 15),

            // TITULO PRINCIPAL
            // ===============================
            const Text(
              "Crear Cuenta",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00A86B),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Registro de clientes VetCare",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 25),

            // TARJETA DEL FORMULARIO
            // ===============================
            Card(
              elevation:
                  8, //esto permite que la tarjeta tenga una sombra para darle un efecto de profundidad
              shape: RoundedRectangleBorder(
                // el shape permite definir la forma de la tarjeta, en este caso se utiliza RoundedRectangleBorder para crear bordes redondeados
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key:
                      formKey, //el formKey es una llave que se utiliza para identificar el formulario y poder ejecutar validaciones sobre él
                  child: Column(
                    children: [
                      // NOMBRE
                      CampoTexto(
                        controller: nombreController,
                        label: "Nombres",
                        icono: Icons.person,

                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return "Ingrese los nombres";
                          }

                          return null;
                        },
                      ),

                      // APELLIDO
                      CampoTexto(
                        controller: apellidoController,
                        label: "Apellidos",
                        icono: Icons.badge,
                      ),

                      // DOCUMENTO
                      // Campo desplegable para seleccionar el tipo de documento
                      DropdownButtonFormField<String>(
                        // Valor seleccionado actualmente
                        // Si está vacío se muestra el hint
                        value: tipoDocumento.isEmpty ? null : tipoDocumento,

                        // Configuración visual del campo
                        decoration: InputDecoration(
                          // Texto que identifica el campo
                          labelText: "Tipo de Documento",

                          // Ícono mostrado al inicio
                          prefixIcon: const Icon(
                            Icons.badge,
                            color: Color(0xFF00A86B),
                          ),

                          // Borde del campo
                          border: OutlineInputBorder(
                            // Bordes redondeados
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),

                        // Lista de opciones que tendrá el desplegable
                        items: tiposDocumento
                            // Excluye la opción vacía
                            .where((item) => item["value"] != "")
                            // Convierte cada elemento en una opción visual
                            .map((item) {
                              return DropdownMenuItem<String>(
                                // Valor interno que se almacenará
                                value: item["value"],

                                // Texto visible para el usuario
                                child: Text(item["label"]!),
                              );
                            })
                            // Convierte el resultado a una lista
                            .toList(),

                        // Evento que se ejecuta cuando el usuario selecciona una opción
                        onChanged: (value) {
                          // Actualiza la interfaz
                          setState(() {
                            // Guarda el valor seleccionado
                            tipoDocumento = value!;
                          });
                        },

                        // Validación del campo
                        validator: (value) {
                          // Verifica que se haya seleccionado una opción
                          if (value == null || value.isEmpty) {
                            return "Seleccione un tipo de documento";
                          }

                          // Sin errores
                          return null;
                        },
                      ),

                      // DIRECCIÓN
                      CampoTexto(
                        controller: calleController,
                        label: "Dirección",
                        icono: Icons.home,
                      ),

                      // CIUDAD
                      CampoTexto(
                        controller: ciudadController,
                        label: "Ciudad",
                        icono: Icons.location_city,
                      ),

                      // PAÍS
                      CampoTexto(
                        controller: paisController,
                        label: "País",
                        icono: Icons.flag,
                      ),

                      // CÓDIGO POSTAL
                      CampoTexto(
                        controller: codigoPostalController,
                        label: "Código Postal",
                        icono: Icons.markunread_mailbox,
                      ),

                      // CORREO
                      CampoTexto(
                        controller: emailController,
                        label: "Correo",
                        icono: Icons.email,

                        tipoTeclado: TextInputType.emailAddress,

                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return "Ingrese el correo";
                          }

                          if (!valor.contains("@")) {
                            return "Correo inválido";
                          }

                          return null;
                        },
                      ),

                      // USUARIO
                      CampoTexto(
                        controller: usuarioController,
                        label: "Usuario",
                        icono: Icons.account_circle,
                      ),

                      // CONTRASEÑA
                      CampoTexto(
                        controller: passwordController,
                        label: "Contraseña",
                        icono: Icons.lock,
                        esPassword: true,

                        validator: (valor) {
                          if (valor == null || valor.length < 6) {
                            return "La contraseña debe tener mínimo 6 caracteres";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      // ===============================
                      // BOTÓN REGISTRAR
                      // ===============================
                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              registrar();
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A86B),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          child: const Text(
                            "REGISTRAR",

                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> registrar() async {
    // Construye el JSON que espera la API
    Map<String, dynamic> datos = {
      "nombre": nombreController.text,

      "apellido": apellidoController.text,

      "documento": {"tipo": tipoDocumento, "numero": documentoController.text},

      "direccion": {
        "calle": calleController.text,

        "ciudad": ciudadController.text,

        "pais": paisController.text,

        "codigoPostal": codigoPostalController.text,
      },

      "email": emailController.text,

      "usuario": usuarioController.text,

      "password": passwordController.text,

      "roles": ["Cliente"],
    };

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/api/usuarios"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode(datos),
      );

      print("Código: ${response.statusCode}");
      print("Respuesta: ${response.body}");

      if (response.statusCode == 201) {
        final respuesta = jsonDecode(response.body);

        print("ID: ${respuesta['id']}");
        print("Nombre: ${respuesta['nombre']}");

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario registrado correctamente")),
        );
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error ${response.statusCode}")));
      }
    } catch (e) {
      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error de conexión: $e")));
    }
  }
}

import 'dart:convert';

import 'package:application_1/fomulario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

// Widget principal del Login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controlador del campo usuario
  final usuarioController = TextEditingController();

  // Controlador del campo contraseña
  final passwordController = TextEditingController();
  // TextEditingController permite acceder al contenido escrito por el usuario.

  // Variable que controla si la contraseñase muestra o se oculta
  bool ocultarPassword = true;

  bool cargando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //El Scaffold es el contenedor principal de la pantalla Flutter.
      backgroundColor: const Color(0xFFF5F7FA),

      body: SafeArea(
        //Evita que el contenido quede debajo de la barra de estado o el notch del dispositivo.
        child: SingleChildScrollView(
          //Permite desplazarse verticalmente.
          padding: const EdgeInsets.all(25),

          child: Column(
            //Organiza los elementos uno debajo del otro.
            children: [
              const SizedBox(height: 40),

              // LOGO
              Container(
                width: 140,
                height: 140,

                decoration: BoxDecoration(
                  //Permite personalizar el Container.
                  color: Color(0xFF00A86B),

                  borderRadius: BorderRadius.circular(70),
                ),
                //icono
                //child: const Icon(Icons.pets, size: 80, color: Colors.white),

                //imagen desde internet
                /*child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    "https://misitio.com/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),*/

                //imagen desde assets
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // TITULO
              const Text(
                "VetCare",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00A86B),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Sistema de Gestión Veterinaria",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // TARJETA
              Card(
                elevation: 8,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      // USUARIO
                      TextField(
                        controller: usuarioController,

                        decoration: InputDecoration(
                          labelText: "Usuario",

                          prefixIcon: const Icon(Icons.person),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD
                      TextField(
                        controller: passwordController,

                        obscureText: ocultarPassword,

                        decoration: InputDecoration(
                          labelText: "Contraseña",

                          prefixIcon: const Icon(Icons.lock),

                          suffixIcon: IconButton(
                            icon: Icon(
                              ocultarPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),

                            onPressed: () {
                              setState(() {
                                ocultarPassword = !ocultarPassword;
                              });
                            },
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // BOTON LOGIN
                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed: cargando ? null : login,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A86B),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          child: cargando
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "INGRESAR",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) => const Registro(),
                            ),
                          );
                        },

                        child: const Text(
                          "¿No tienes cuenta? Regístrate",
                          style: TextStyle(
                            color: Color(0xFF00A86B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Cuidando la salud de tus mascotas",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    setState(() {
      cargando = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8080/auth/login"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({
          "usuario": usuarioController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> datos = jsonDecode(response.body);

        print(datos);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario o contraseña incorrectos")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() {
      cargando = false;
    });
  }
}

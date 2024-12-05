import 'package:fl_components/screens/listview1_screen.dart';
import 'package:fl_components/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo completamente negro
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signin(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Center(
                child: Text(
                  'GONORT TECH REGISTRO',
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      color: Colors.white, // Texto en blanco
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              _emailAddress(),
              const SizedBox(height: 20),
              _password(),
              const SizedBox(height: 50),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingresa tu correo',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.white, // Texto en blanco
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white), // Texto del campo en blanco
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff1E1E1E), // Fondo del campo oscuro
            hintText: 'ejemplo@gmail.com',
            hintStyle: const TextStyle(
              color: Colors.grey, // Texto de pista gris
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingresa tu contraseña',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.white, // Texto en blanco
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white), // Texto del campo en blanco
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff1E1E1E), // Fondo del campo oscuro
            hintText: 'hjdbawdnawdnadnakdnkas',
            hintStyle: const TextStyle(
              color: Colors.grey, // Texto de pista gris
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff1E88E5), // Azul para el botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      onPressed: () async {
        await AuthService().signup(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
      },
      child: const Text(
        "Registrate",
        style: TextStyle(
          color: Colors.white, // Texto en blanco
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _signin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "¿Ya tienes una cuenta? ",
              style: TextStyle(
                color: Colors.white, // Texto en blanco
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: "Ingresa",
              style: const TextStyle(
                color: Color(0xff1E88E5), // Azul para el enlace
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fl_components/screens/signup.dart';
import 'package:fl_components/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 7, 21), // Color uniforme en todo el fondo
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signup(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              _appBar(context),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'GONORT TECH',
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              _emailAddress(),
              const SizedBox(height: 20),
              _password(),
              const SizedBox(height: 40),
              _signin(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            color: Color(0xffF7F7F9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
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
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              hintText: 'ejemplo@gmail.com',
              hintStyle: const TextStyle(
                color: Color(0xff6A6A6A),
                fontSize: 14,
              ),
              fillColor: const Color.fromARGB(255, 0, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
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
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            obscureText: true,
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 0, 0, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signin(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 41, 103),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 60),
          elevation: 0, // Elevación ya manejada por el `boxShadow`
        ),
        onPressed: () async {
          await AuthService().signin(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
        },
        child: const Text(
          "Ingresar",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.996),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "¿Aun no tienes cuenta? ",
              style: TextStyle(
                color: Color(0xff6A6A6A),
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: "Crea una ahora!",
              style: const TextStyle(
                color: Color(0xff0D6EFD),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

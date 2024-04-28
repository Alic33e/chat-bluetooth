import 'package:flutter/material.dart';
import 'package:myapp2/pages/register_page.dart';
import 'package:myapp2/pages/home_page.dart'; // Asegúrate de usar la ruta correcta a tu archivo

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'LOGO',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Celular o correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text('Iniciar sesión'),
                  onPressed: () {
                    // Handle login logic here
                    // If login is successful, navigate to HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                ),
                TextButton(
                  child: Text('¿Olvidaste tu contraseña?'),
                  onPressed: () {
                    // Handle forgot password logic here
                  },
                ),
              ],
            ),
            TextButton(
              child: Text('Crear cuenta nueva'),
              onPressed: () {
                // Navigate to the register page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
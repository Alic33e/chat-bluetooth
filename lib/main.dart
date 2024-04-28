import 'package:flutter/material.dart';
import 'package:myapp2/pages/login_page.dart';
import 'package:myapp2/pages/register_page.dart';
import 'package:myapp2/pages/cargar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

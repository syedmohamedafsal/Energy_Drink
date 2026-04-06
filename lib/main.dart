import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/energy_drink_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy Drink 3D App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const EnergyDrinkScreen(),
    );
  }
}

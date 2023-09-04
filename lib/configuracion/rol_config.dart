import 'package:flutter/material.dart';

abstract class RolConfig {
  String appNombre() {
    return 'Cliente eDreams';
  }

  Color colorPrimario() {
    return Colors.pink;
  }

  Color colorPrimarioOscuro() {
    return const Color(0xffE91E63);
  }

  ThemeData tema() {
    return ThemeData.light();
  }

  ThemeData temaOscuro() {
    return ThemeData.dark();
  }
}

import 'package:edreams/configuracion/rol_config.dart';
import 'package:edreams/temas/pie_pagina_personalizado.dart';
import 'package:edreams/temas/tipo_texto_personalizado.dart';
import 'package:flutter/material.dart';

import '../temas/decoracion_input_personalizada.dart';

class AdminConfig implements RolConfig {
 
  @override
  String appNombre() {
    return 'Administrador E-dreams';
  }

 
  @override
  Color colorPrimario() {
    return Colors.pink;
  }

  // TODO: Cambiar el color primario oscuro
  @override
  Color colorPrimarioOscuro() {
    return const Color(0xffE91E63);
  }

  @override
  ThemeData tema() {
    return ThemeData(
      primaryColor: colorPrimario(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorPrimario(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorPrimario(),
      ),
      useMaterial3: true,
      textTheme: TipoTextoPersonalizado.tipoTexto,
      inputDecorationTheme: DecoracionPersonalizada.TipoDecoracion,
      bottomSheetTheme: PiePaginaPersonalizado.TipoPiePagina,
    );
  }

  @override
  ThemeData temaOscuro() {
    return ThemeData(
      primaryColorDark: colorPrimarioOscuro(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorPrimarioOscuro(),
        brightness: Brightness.dark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorPrimarioOscuro(),
      ),
      useMaterial3: true,
      textTheme: TipoTextoPersonalizado.tipoTexto,
      inputDecorationTheme: DecoracionPersonalizada.TipoDecoracion,
      bottomSheetTheme: PiePaginaPersonalizado.TipoPiePagina,
    );
  }
}

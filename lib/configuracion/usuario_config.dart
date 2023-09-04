import 'package:edreams/configuracion/rol_config.dart';
import 'package:edreams/temas/decoracion_input_personalizada.dart';
import 'package:edreams/temas/pie_pagina_personalizado.dart';
import 'package:edreams/temas/tipo_texto_personalizado.dart';
import 'package:flutter/material.dart';

class UsuarioConfig implements RolConfig {
  // TODO: Cambiar nombre de la app
  @override
  String appNombre() {
    return 'Edreams: Tienda de ropa';
  }

  // TODO: Cambiar el color de la app
  @override
  Color colorPrimario() {
    return Colors.pink;
  }

  // TODO: Cambiar el color oscuro de la app
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
      useMaterial3: true,
      textTheme: TipoTextoPersonalizado.tipoTexto,
      inputDecorationTheme: DecoracionPersonalizada.TipoDecoracion,
      bottomSheetTheme: PiePaginaPersonalizado.TipoPiePagina,
    );
  }
}

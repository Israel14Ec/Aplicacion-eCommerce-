import 'package:edreams/app/proveedores/proveedor_modo_oscuro.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FlavorConfig flavor = FlavorConfig.instancia;

class ValorColores {
  static Color colorPrimario(BuildContext context) {
    return context.read<ProveedorModoOscuro>().isModoOscuro
        ? flavor.flavorValores.rolConfig.colorPrimarioOscuro()
        : flavor.flavorValores.rolConfig.colorPrimario();
  }
}

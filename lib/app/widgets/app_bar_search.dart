import 'package:edreams/app/widgets/carrito/distintivo_carrito.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:flutter/material.dart';

import '../../verificaciones/debouncer.dart';

class AppBarBusqueda extends StatefulWidget implements PreferredSizeWidget {
  final void Function(String?) onChanged;
  final TextEditingController controlador;
  final String textoSugerencia;
  final PreferredSizeWidget? bottom;
  const AppBarBusqueda({
    Key? key,
    required this.onChanged,
    required this.controlador,
    required this.textoSugerencia,
    this.bottom,
  }) : super(key: key);

  @override
  State<AppBarBusqueda> createState() => _AppBarBusquedaState();

  @override
  Size get preferredSize => _SizePreferidoAppBar(kToolbarHeight, bottom?.preferredSize.height);
}

class _AppBarBusquedaState extends State<AppBarBusqueda> {
  FlavorConfig flavor = FlavorConfig.instancia;

  Debouncer db = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: TextField(
        controller: widget.controlador,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: widget.textoSugerencia,
          isDense: true,
          prefixIcon: const Icon(Icons.search_rounded),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        onChanged: (valor) {
          db.call(() {
            widget.onChanged(valor);
          });
        },
      ),
      actions: flavor.flavor == Flavor.usuario
          ? [
              const DistintivoCarrito(),
              const SizedBox(width: 32),
            ]
          : null,
    );
  }
}

class _SizePreferidoAppBar extends Size {
  _SizePreferidoAppBar(this.altoToolbar, this.altoBottom)
      : super.fromHeight((altoToolbar ?? kToolbarHeight) + (altoBottom ?? 0));

  final double? altoToolbar;
  final double? altoBottom;
}

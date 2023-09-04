import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:flutter/material.dart';

class SeleccionarDireccionEnvio extends StatelessWidget {
  final Direccion direccion;
  const SeleccionarDireccionEnvio({
    Key? key,
    required this.direccion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direccion Envio',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        ListTile(
          dense: true,
          title: Text(direccion.nombre),
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(vertical: -4),
          subtitle: Text(
            '${direccion.direccion} ${direccion.ciudad} ${direccion.codigoCasa}',
          ),
        ),
      ],
    );
  }
}

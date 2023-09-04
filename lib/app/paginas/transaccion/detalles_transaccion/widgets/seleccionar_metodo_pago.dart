import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:flutter/material.dart';

class SeleccionarMetodoPago extends StatelessWidget {
  final MetodoPago metodoPago;

  const SeleccionarMetodoPago({
    Key? key,
    required this.metodoPago,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metodo de Pago',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        ListTile(
          dense: true,
          title: Text(metodoPago.nombreUsuarioTarjeta),
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(vertical: -4),
          subtitle: Text(
            metodoPago.numeroTarjeta,
          ),
        ),
      ],
    );
  }
}

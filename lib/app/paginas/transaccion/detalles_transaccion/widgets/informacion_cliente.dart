import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class InformacionCliente extends StatelessWidget {
  final Cuenta cliente;
  const InformacionCliente({
    super.key,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informacion del Cliente',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nombre',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              cliente.nombre,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              cliente.email,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Numero Telefonico',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              cliente.numeroTelefonico.separarCodigoPais(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/seleccionar_metodo_pago.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ColumnaResumenPago extends StatelessWidget {
  final double cuentaTotal;
  final double iva;
  final double pagoTotal;
  final MetodoPago metodoPago;
  const ColumnaResumenPago({
    super.key,
    required this.cuentaTotal,
    required this.iva,
    required this.pagoTotal,
    required this.metodoPago,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumen Pago',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        SeleccionarMetodoPago(
          metodoPago: metodoPago,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cuenta Total',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              cuentaTotal.toCurrency(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Iva',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              iva.toCurrency(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pago Total',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              pagoTotal.toCurrency(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}

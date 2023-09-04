import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/seleccionar_direccion_envio.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ColumnaResumenOrden extends StatelessWidget {
  final int contarObjetos;
  final double precioTotal;
  final double costeEnvio;
  final Direccion direccion;
  const ColumnaResumenOrden({
    super.key,
    required this.contarObjetos,
    required this.precioTotal,
    required this.costeEnvio,
    required this.direccion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumen de la Orden',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        SeleccionarDireccionEnvio(
          direccion: direccion,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Precio Total ($contarObjetos Objetos)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              precioTotal.toCurrency(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Coste Envio',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              costeEnvio.toCurrency(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}

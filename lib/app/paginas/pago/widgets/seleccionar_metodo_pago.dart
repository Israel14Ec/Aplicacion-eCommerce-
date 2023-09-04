import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:flutter/material.dart';

class SeleccionarMetodoPago extends StatelessWidget {
  final MetodoPago? metodoPago;
  final Function() seleccionarMetodoPago;
  final Function() removerMetodoPago;
  const SeleccionarMetodoPago({
    Key? key,
    this.metodoPago,
    required this.seleccionarMetodoPago,
    required this.removerMetodoPago,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Metodo de pago',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (metodoPago != null)
              TextButton(
                onPressed: () {
                  seleccionarMetodoPago();
                },
                child: const Text('Otros Metodos'),
              ),
          ],
        ),
        if (metodoPago == null)
          TextButton.icon(
            onPressed: () {
              seleccionarMetodoPago();
            },
            icon: Icon(
              Icons.add_rounded,
              color: ValorColores.colorPrimario(context),
            ),
            label: const Text('Añadir Metodo Pago'),
          ),
        if (metodoPago != null)
          ListTile(
            dense: true,
            title: Text(metodoPago!.nombreUsuarioTarjeta),
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4),
            subtitle: Text(
              metodoPago!.numeroTarjeta,
            ),
            trailing: IconButton(
              onPressed: () {
                removerMetodoPago();
              },
              icon: const Icon(
                Icons.clear_rounded,
                color: ColorPersonalizado.error,
              ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

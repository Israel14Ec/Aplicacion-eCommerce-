import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ContadorCantidadCarrito extends StatelessWidget {
  final int cantidad;
  final void Function()? onTapAdd;
  final void Function()? onTapRemove;
  const ContadorCantidadCarrito({
    Key? key,
    required this.cantidad,
    this.onTapAdd,
    this.onTapRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTapRemove,
          child: Icon(
            Icons.remove_rounded,
            color: ValorColores.colorPrimario(context),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          cantidad.toNumericFormat(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTapAdd,
          child: Icon(
            Icons.add_rounded,
            color: ValorColores.colorPrimario(context),
          ),
        ),
      ],
    );
  }
}

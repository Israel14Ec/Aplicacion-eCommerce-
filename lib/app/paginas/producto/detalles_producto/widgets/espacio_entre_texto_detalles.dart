import 'package:flutter/material.dart';

class EspacioEntreTextoDetalles extends StatelessWidget {
  final String textoIzquierda;
  final String textoDerecha;
  const EspacioEntreTextoDetalles({Key? key, required this.textoIzquierda, required this.textoDerecha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textoIzquierda,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          textoDerecha,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

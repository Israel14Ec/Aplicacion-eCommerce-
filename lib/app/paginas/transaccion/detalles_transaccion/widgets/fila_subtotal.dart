import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class FilaSubtotal extends StatelessWidget {
  final double subtotal;
  const FilaSubtotal({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subtotal',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          subtotal.toCurrency(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

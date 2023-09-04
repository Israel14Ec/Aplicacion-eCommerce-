import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FechaCompra extends StatelessWidget {
  final DateTime date;
  const FechaCompra({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Fecha de Compra',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          DateFormat('dd MMMM yyyy, HH:mm').format(date),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

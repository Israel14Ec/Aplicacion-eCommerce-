import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:flutter/material.dart';

class FragmentoEstadoTransaccion extends StatelessWidget {
  final int estado;
  const FragmentoEstadoTransaccion({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.amber.shade100;
    Color textoColor = Colors.amber.shade900;
    String labelTexto = 'Procesado';
    EstadoTransaccion estadoTransaccion = EstadoTransaccion.values.where((elemento) => elemento.valor == estado).first;

    switch (estadoTransaccion) {
      case EstadoTransaccion.procesado:
        labelTexto = 'Procesado';
        break;
      case EstadoTransaccion.enviado:
        labelTexto = 'Enviado';
        break;
      case EstadoTransaccion.entregado:
        labelTexto = 'Enviado';
        backgroundColor = Colors.green.shade50;
        textoColor = Colors.green;
        break;
      case EstadoTransaccion.recibido:
        labelTexto = 'Recibido';
        backgroundColor = Colors.green.shade50;
        textoColor = Colors.green;
        break;
      case EstadoTransaccion.rechazado:
        labelTexto = 'Rechazado';
        backgroundColor = Colors.red.shade50;
        textoColor = Colors.red;
        break;
      case EstadoTransaccion.calificado:
        labelTexto = 'Calificado';
        backgroundColor = Colors.green.shade50;
        textoColor = Colors.green;
        break;
      default:
    }

    return Chip(
      backgroundColor: backgroundColor,
      labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: textoColor, fontWeight: FontWeight.w500),
      side: BorderSide.none,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(vertical: -4),
      label: Text(labelTexto),
    );
  }
}

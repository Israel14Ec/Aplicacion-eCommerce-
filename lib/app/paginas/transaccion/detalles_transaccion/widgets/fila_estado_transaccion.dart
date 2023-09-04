import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:flutter/material.dart';

class FilaEstadoTransaccion extends StatelessWidget {
  final int estado;
  final String transaccionID;
  const FilaEstadoTransaccion({super.key, required this.estado, required this.transaccionID});

  @override
  Widget build(BuildContext context) {
    String textoEstado = 'Procesado';
    Color colorEstado = Colors.amber.shade900;

    EstadoTransaccion estadoTransaccion = EstadoTransaccion.values.where((elemento) => elemento.valor == estado).first;

    switch (estadoTransaccion) {
      case EstadoTransaccion.procesado:
        textoEstado = 'Procesado';
        break;
      case EstadoTransaccion.enviado:
        textoEstado = 'Enviado';
        break;
      case EstadoTransaccion.entregado:
        textoEstado = 'Entregado';
        colorEstado = Colors.green;
        break;
      case EstadoTransaccion.recibido:
        textoEstado = 'Recibido';
        colorEstado = Colors.green;
        break;
      case EstadoTransaccion.rechazado:
        textoEstado = 'Rechazado';
        colorEstado = Colors.red;
        break;
      case EstadoTransaccion.calificado:
        textoEstado = 'Calificado';
        colorEstado = Colors.green;
        break;
      default:
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorEstado,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 3,
          ),
          const SizedBox(width: 4.0),
          Text(
            textoEstado,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              transaccionID,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

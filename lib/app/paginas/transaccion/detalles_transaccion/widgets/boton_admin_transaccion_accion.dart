import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/estado_transaccion_checkbox.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotonAdminTransaccionAccion extends StatelessWidget {
  final String transaccionID;
  final int transaccionEstado;
  const BotonAdminTransaccionAccion({
    super.key,
    required this.transaccionEstado,
    required this.transaccionID,
  });

  @override
  Widget build(BuildContext context) {
    EstadoTransaccion estado = EstadoTransaccion.values.where((elemento) => elemento.valor == transaccionEstado).first;

    void Function()? onPressed;
    String labelText = '';

    switch (estado) {
      case EstadoTransaccion.recibido:
        labelText = 'Recibido';
        break;
      case EstadoTransaccion.calificado:
        labelText = 'Calificado';
        break;
      default:
        labelText = 'Cambiar Estado';
        onPressed = () async {
          await showModalBottomSheet<EstadoTransaccion>(
            context: context,
            builder: (context) {
              return EstadoTransaccionCheckbox(seleccionarEstado: estado);
            },
          ).then((estado) {
            if (estado != null) {
              context.read<ProveedorTransaccion>().cambiarEstado(transaccionId: transaccionID, estado: 3);
            }
          });
        };
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(labelText),
      ),
    );
  }
}

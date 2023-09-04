import 'package:edreams/app/paginas/transaccion/lista_transaccion/widgets/contenedor_transaccion_producto.dart';
import 'package:edreams/app/paginas/transaccion/lista_transaccion/widgets/fragmento_estado_transaccion.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/rutas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContenedorTransaccion extends StatelessWidget {
  final Transaccion objeto;
  const ContenedorTransaccion({super.key, required this.objeto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RutaNavegacion.toDetallesTransaccion(context: context, transaccionID: objeto.transaccionId);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: objeto.cuenta?.nombre ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: objeto.cuenta != null ? ' - ' : '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: DateFormat('dd MMM yyyy').format(objeto.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              FragmentoEstadoTransaccion(estado: objeto.estadoTransaccion!),
            ],
          ),
          ContenedorTransaccionProducto(
            objeto: objeto.productoComprado.first,
            contarOtrosObjetos: objeto.productoComprado.length - 1,
            pagoTotal: objeto.totalPagar!,
          ),
        ],
      ),
    );
  }
}

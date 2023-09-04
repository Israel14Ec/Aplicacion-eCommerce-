import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ContenedorTransaccionProducto extends StatelessWidget {
  final Carrito objeto;
  final int contarOtrosObjetos;
  final double pagoTotal;
  const ContenedorTransaccionProducto({Key? key, required this.objeto, required this.contarOtrosObjetos, required this.pagoTotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              objeto.producto!.productoImagen.first,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progresoCarga) {
                if (progresoCarga == null) return child;

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                objeto.producto!.productoNombre,
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${objeto.cantidad.toNumericFormat()} Objetos',
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Total : ${pagoTotal.toCurrency()}',
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              if (contarOtrosObjetos > 0)
                Text(
                  '+${contarOtrosObjetos.toNumericFormat()} Otros Objetos',
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

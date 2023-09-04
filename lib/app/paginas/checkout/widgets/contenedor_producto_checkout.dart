import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ContenedorProductoCheckout extends StatelessWidget {
  final Carrito elemento;
  const ContenedorProductoCheckout({Key? key, required this.elemento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        RutaNavegacion.toDetallesProducto(context: context, productoId: elemento.productoId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: 90,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                elemento.producto!.productoImagen.first,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    elemento.producto!.productoNombre,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    elemento.producto!.productoPrecio.toCurrency(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Cantidad: ${elemento.cantidad.toNumericFormat()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

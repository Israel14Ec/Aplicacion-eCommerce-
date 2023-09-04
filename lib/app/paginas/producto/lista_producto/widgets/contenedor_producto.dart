import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class ContenedorProducto extends StatelessWidget {
  final Producto objeto;
  final Function() onTap;
  const ContenedorProducto({
    Key? key,
    required this.objeto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                objeto.productoImagen.first,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progresoCarga) {
                  if (progresoCarga == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                      value: progresoCarga.expectedTotalBytes != null
                          ? progresoCarga.cumulativeBytesLoaded / progresoCarga.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            objeto.productoNombre,
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            objeto.productoPrecio.toCurrency(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          if (objeto.rating != 0)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: ColorPersonalizado.warning,
                ),
                const SizedBox(width: 8),
                Text(
                  '${objeto.rating}' ' ' '(${objeto.reviewsTotal} Reviews)',
                ),
              ],
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

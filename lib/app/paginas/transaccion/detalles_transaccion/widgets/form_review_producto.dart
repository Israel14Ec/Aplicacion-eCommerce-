import 'package:edreams/app/widgets/contador_estrellas.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:flutter/material.dart';

class FormReviewProducto extends StatelessWidget {
  final Review data;
  final void Function(int estrella) onTapStar;

  const FormReviewProducto({
    super.key,
    required this.data,
    required this.onTapStar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Producto Review',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  data.producto.productoImagen.first,
                  width: 70,
                  height: 70,
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
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.producto.productoNombre,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  ContadorEstrellas(
                    estrella: data.estrellas,
                    dimensionEstrellas: 24,
                    onTapStar: onTapStar,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Cuentanos sobre este producto',
              labelText: 'Descripcion (Opcional)', //Como terminar la puta carrera 1 semana sin dormir muerte a Correa
            ),
            onChanged: (valor) {
              data.descripcion = valor;
            },
          ),
        ],
      ),
    );
  }
}

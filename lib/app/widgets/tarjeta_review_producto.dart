import 'package:edreams/app/widgets/contador_estrellas.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TarjetaReviewProducto extends StatelessWidget {
  final Review objeto;
  const TarjetaReviewProducto({Key? key, required this.objeto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              objeto.nombreReviewer,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              timeago.format(objeto.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        const SizedBox(height: 4),
        ContadorEstrellas(
          estrella: objeto.estrellas,
          dimensionEstrellas: 16,
        ),
        const SizedBox(height: 8),
        Text(
          objeto.descripcion ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

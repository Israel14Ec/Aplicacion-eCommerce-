import 'package:edreams/temas/color_personalizado.dart';
import 'package:flutter/material.dart';

class DetallesRatingReview extends StatelessWidget {
  final double rating;
  final int totalReviews;
  final Function() onTapSeeAll;
  const DetallesRatingReview({Key? key, required this.rating, required this.totalReviews, required this.onTapSeeAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.star_rounded,
              size: 24,
              color: ColorPersonalizado.warning,
            ),
            const SizedBox(width: 8),
            Text(
              '$rating ($totalReviews Reviews)',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            onTapSeeAll();
          },
          child: Text(
            'Ver todos los reviews',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

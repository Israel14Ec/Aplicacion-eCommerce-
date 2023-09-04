import 'package:edreams/temas/color_personalizado.dart';
import 'package:flutter/material.dart';

class ContadorEstrellas extends StatelessWidget {
  final int estrella;
  final double dimensionEstrellas;
  final void Function(int estrella)? onTapStar;

  const ContadorEstrellas({
    Key? key,
    required this.estrella,
    required this.dimensionEstrellas,
    this.onTapStar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (indice) {
        if (indice >= estrella) {
          return InkWell(
            onTap: onTapStar == null
                ? null
                : () {
                    onTapStar!(indice + 1);
                  },
            child: Icon(
              Icons.star_outline_rounded,
              size: dimensionEstrellas,
              color: Colors.blueGrey,
            ),
          );
        } else {
          return InkWell(
            onTap: onTapStar == null
                ? null
                : () {
                    onTapStar!(indice + 1);
                  },
            child: Icon(
              Icons.star_rate_rounded,
              size: dimensionEstrellas,
              color: ColorPersonalizado.warning,
            ),
          );
        }
      }),
    );
  }
}

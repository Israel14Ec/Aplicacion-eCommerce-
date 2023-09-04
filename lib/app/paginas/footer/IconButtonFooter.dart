import 'package:flutter/material.dart';

class IconButtonFooter extends StatelessWidget {
  final IconData iconUser;
  final double size;
  const IconButtonFooter({
    required this.iconUser,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // Acción al presionar el ícono de Facebook
        },
        child: Ink(
          child: IconButton(
            icon: Icon(
              iconUser ,
            ),
            iconSize: size, // Establece el tamaño del ícono aquí
            onPressed: null,
          ),
        ),
      ),
    );
  }
}

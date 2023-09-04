import 'package:flutter/material.dart';

class IconFooter extends StatelessWidget {
  final IconData icon;
  final String descripcion;

  const IconFooter({
    required this.icon,
    required this.descripcion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          size: 45,
        ),
        Text(
          descripcion,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';

class TileInfoPersonal extends StatelessWidget {
  final String infoPersonal;
  final String valor;
  final Function() onTap;
  const TileInfoPersonal({Key? key, required this.infoPersonal, required this.valor, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Text(infoPersonal),
      title: Text(valor),
      trailing: const Icon(
        Icons.navigate_next_rounded,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BotonDetallesAccion extends StatelessWidget {
  final Function() onTapDeleteProducto;
  final Function() onTapEditProducto;
  const BotonDetallesAccion({
    Key? key,
    required this.onTapDeleteProducto,
    required this.onTapEditProducto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                onTapDeleteProducto();
              },
              child: const Text('Eliminar Producto'),
            ),
          ),
          const SizedBox(width: 32.0),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onTapEditProducto();
              },
              child: const Text('Editar Producto'),
            ),
          ),
        ],
      ),
    );
  }
}

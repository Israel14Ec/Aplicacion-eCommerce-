import 'package:flutter/material.dart';

import 'detalles_imagen_producto.dart';

class TarjetaDetallesImagenProducto extends StatelessWidget {
  final String urlImagen;
  final int indice;
  const TarjetaDetallesImagenProducto({Key? key, required this.urlImagen, required this.indice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.36,
      margin: const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetallesProductoImagen(
                  urlImagen: urlImagen,
                  indice: indice,
                ),
              ),
            );
          },
          child: Hero(
            tag: 'detalle_imagen' '$indice',
            child: Image.network(
              urlImagen,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progresoCarga) {
                if (progresoCarga == null) return child;

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
        ),
      ),
    );
  }
}

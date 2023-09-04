import 'package:flutter/material.dart';

class DetallesProductoImagen extends StatelessWidget {
  final String urlImagen;
  final int indice;
  const DetallesProductoImagen({Key? key, required this.urlImagen, required this.indice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Hero(
                tag: 'detalles_imagen' '$indice',
                child: InteractiveViewer(
                  child: Image.network(
                    urlImagen,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progresoCarga) {
                      if (progresoCarga == null) return child;

                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              progresoCarga.expectedTotalBytes != null ? progresoCarga.cumulativeBytesLoaded / progresoCarga.expectedTotalBytes! : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

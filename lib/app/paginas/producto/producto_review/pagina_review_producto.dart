import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/app/widgets/contador_y_opciones.dart';
import 'package:edreams/app/widgets/tarjeta_review_producto.dart';
import 'package:edreams/core/dominio/entidades/review/review.dart';
import 'package:flutter/material.dart';

import '../../../widgets/ficha_orden_filtrado.dart';

class PaginaReviewProducto extends StatefulWidget {
  const PaginaReviewProducto({Key? key}) : super(key: key);

  @override
  State<PaginaReviewProducto> createState() => _PaginaReviewProductoState();
}

class _PaginaReviewProductoState extends State<PaginaReviewProducto> {
  // Ordenar
  OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo;
  List<OrdenarPorEnum> dataEnum = [];

  @override
  void initState() {
    dataEnum.addAll(OrdenarPorEnum.values);
    dataEnum.removeRange(2, 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Review> productoReview = ModalRoute.of(context)!.settings.arguments as List<Review>;

    sortProductReview() {
      switch (ordenarPorEnum) {
        case OrdenarPorEnum.nuevo:
          productoReview.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
          );
          break;
        case OrdenarPorEnum.viejo:
          productoReview.sort(
            (a, b) => a.createdAt.compareTo(b.createdAt),
          );
          break;
        case OrdenarPorEnum.menosEstrellas:
          productoReview.sort(
            (a, b) => b.estrellas.compareTo(a.estrellas),
          );
          break;
        case OrdenarPorEnum.masEstrellas:
          productoReview.sort(
            (a, b) => a.estrellas.compareTo(b.estrellas),
          );
          break;
        default:
          productoReview.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
          );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: productoReview.isEmpty
          ? Center(
              child: Text(
                'Aun no hay reviews del producto',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Count Reviews & Sort Reviews
                  ContadorYOpciones(
                    contador: productoReview.length,
                    nombreObjeto: 'Reviews',
                    isOrdenada: true,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return FichaOrdenFiltrado(
                                dataEnum: dataEnum,
                                onSelected: (valor) {
                                  setState(() {
                                    ordenarPorEnum = valor;
                                    sortProductReview();
                                  });
                                },
                                seleccionadoEnum: ordenarPorEnum,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ...productoReview.map((e) => TarjetaReviewProducto(objeto: e))
                ],
              ),
            ),
    );
  }
}

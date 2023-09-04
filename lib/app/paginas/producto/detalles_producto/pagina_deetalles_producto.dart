import 'package:edreams/app/paginas/producto/detalles_producto/widgets/boton_accion_usuario.dart';
import 'package:edreams/app/paginas/producto/detalles_producto/widgets/boton_detalles_accion.dart';
import 'package:edreams/app/paginas/producto/detalles_producto/widgets/detalles_rating_review.dart';
import 'package:edreams/app/paginas/producto/detalles_producto/widgets/espacio_entre_texto_detalles.dart';
import 'package:edreams/app/paginas/producto/detalles_producto/widgets/tarjeta_detalles_imagen_producto.dart';
import 'package:edreams/app/proveedores/proveedor_carrito.dart';
import 'package:edreams/app/proveedores/proveedor_lista_deseos.dart';
import 'package:edreams/app/proveedores/proveedor_producto.dart';
import 'package:edreams/app/widgets/carrito/distintivo_carrito.dart';
import 'package:edreams/app/widgets/tarjeta_review_producto.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class PaginaDetallesProducto extends StatefulWidget {
  const PaginaDetallesProducto({Key? key}) : super(key: key);

  @override
  State<PaginaDetallesProducto> createState() => _PaginaDetallesProductoState();
}

class _PaginaDetallesProductoState extends State<PaginaDetallesProducto> {
  final FlavorConfig _flavorConfig = FlavorConfig.instancia;

  String cuentaId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    Future.microtask(() {
      String productoId = ModalRoute.of(context)!.settings.arguments as String;

      context.read<ProveedorProducto>().cargarDetallesProducto(productoId: productoId);
      var proveedorListaDeseos = context.read<ProveedorListaDeseos>();
      if (proveedorListaDeseos.listListaDeseos.isEmpty) {
        proveedorListaDeseos.cargarListaDeseos(cuentaId: cuentaId);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles producto'),
        actions: _flavorConfig.flavor == Flavor.usuario
            ? [
                const DistintivoCarrito(),
                const SizedBox(width: 32),
              ]
            : null,
      ),
      body: Consumer2<ProveedorProducto, ProveedorListaDeseos>(
        builder: (context, valor, valor2, child) {
          if (valor.isCargando || valor.detalleProducto == null || valor2.isDataCargada) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              // Detail
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Lista de imagenes de producto
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...valor.detalleProducto!.productoImagen.map((urlImagen) {
                              int indice = valor.detalleProducto!.productoImagen.indexOf(urlImagen);
                              return TarjetaDetallesImagenProducto(urlImagen: urlImagen, indice: indice);
                            })
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Nombre del producto y precio
                      EspacioEntreTextoDetalles(
                        textoIzquierda: valor.detalleProducto!.productoNombre,
                        textoDerecha: NumberFormat.compactCurrency(locale: 'en_US', symbol: '\$').format(valor.detalleProducto!.productoPrecio),
                      ),
                      const SizedBox(height: 12),

                      // Producto Stock
                      EspacioEntreTextoDetalles(
                        textoIzquierda: 'Stock restante',
                        textoDerecha: valor.detalleProducto!.stock.toNumericFormat(),
                      ),
                      const SizedBox(height: 12),

                      // Descripcion
                      Text(
                        'Descripcion',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        valor.detalleProducto!.productoDescripcion,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),

                      // Rating (Reviews)
                      DetallesRatingReview(
                        rating: valor.detalleProducto!.rating,
                        totalReviews: valor.detalleProducto!.reviewsTotal,
                        onTapSeeAll: () {
                          RutaNavegacion.toProductoReview(context: context, productoReview: valor.listaProductoReview);
                        },
                      ),
                      const SizedBox(height: 12),

                      // Lista de reviews
                      if (valor.listaProductoReview.isEmpty)
                        Center(
                          child: Text(
                            'No hay reviews del producto todavía',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),

                      if (valor.listaProductoReview.isNotEmpty)
                        Column(
                          children: [
                            ...valor.listaProductoReview.map((item) {
                              return TarjetaReviewProducto(objeto: item);
                            })
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              // Boton de accion
              _flavorConfig.flavor == Flavor.usuario
                  ? Consumer2<ProveedorCarrito, ProveedorListaDeseos>(
                      builder: (context, proveedorCarrito, proveedorListaDeseos, child) {
                        if (proveedorCarrito.isCargando || proveedorListaDeseos.isCargando) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        bool isListaDeseos = proveedorListaDeseos.listListaDeseos.any((elemento) => elemento.productoId == valor.detalleProducto!.productoId);

                        return BotonAccionUsuario(
                          isListaDeseos: isListaDeseos,
                          onTapFavorite: () async {
                            if (isListaDeseos) {
                              String listadeseosId =
                                  proveedorListaDeseos.listListaDeseos.where((elemento) => elemento.productoId == valor.detalleProducto!.productoId).first.listadeseosId;
                              await proveedorListaDeseos.delete(cuentaId: cuentaId, listadeseosId: listadeseosId);
                              return;
                            }

                            var data = ListaDeseos(
                              listadeseosId: ''.generateUID(),
                              productoId: valor.detalleProducto!.productoId,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            await proveedorListaDeseos.add(cuentaId: cuentaId, data: data);
                          },
                          onTapAddToCart: valor.detalleProducto!.stock == 0
                              ? null
                              : () async {
                                  String cuentaId = FirebaseAuth.instance.currentUser!.uid;

                                  // Revisa si el producto existe en el carrito
                                  // Si existe añade la cantidad
                                  if (proveedorCarrito.contadorCarrito != 0) {
                                    for (var elemento in proveedorCarrito.listaCarrito) {
                                      if (elemento.productoId == valor.detalleProducto!.productoId) {
                                        Carrito data = elemento;
                                        data.cantidad += 1;
                                        data.total = data.producto!.productoPrecio * data.cantidad;
                                        await proveedorCarrito.updateCarrito(data: data);
                                        return;
                                      }
                                    }
                                  }

                                  // Añadir al carrito
                                  Carrito data = Carrito(
                                    carritoId: ''.generateUID(),
                                    producto: valor.detalleProducto,
                                    productoId: valor.detalleProducto!.productoId,
                                    cantidad: 1,
                                    total: valor.detalleProducto!.productoPrecio,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                  );
                                  await proveedorCarrito.addCarrito(cuentaId: cuentaId, data: data);
                                },
                        );
                      },
                    )
                  : BotonDetallesAccion(
                      onTapDeleteProducto: () async {
                        var respuesta = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('¿Desea eliminar este producto?'),
                              content: const Text('Este producto sera eliminado permanente'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Abortar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('Continuar'),
                                ),
                              ],
                            );
                          },
                        );

                        if (respuesta != null) {
                          await valor.delete(productoId: valor.detalleProducto!.productoId).whenComplete(() {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Producto eliminado exitosamente'),
                              ),
                            );
                            valor.cargarListaProducto();
                          });
                        }
                      },
                      onTapEditProducto: () {
                        RutaNavegacion.toEditProducto(context: context, producto: valor.detalleProducto!);
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}

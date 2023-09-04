import 'package:edreams/app/proveedores/proveedor_carrito.dart';
import 'package:edreams/app/proveedores/proveedor_lista_deseos.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/core/dominio/entidades/lista_deseos/listadeseos.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContenedorListaDeseos extends StatelessWidget {
  final ListaDeseos listaDeseos;
  const ContenedorListaDeseos({Key? key, required this.listaDeseos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        RutaNavegacion.toDetallesProducto(context: context, productoId: listaDeseos.productoId);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                listaDeseos.producto!.productoImagen.first,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progresoCarga) {
                  if (progresoCarga == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                      value: progresoCarga.expectedTotalBytes != null
                          ? progresoCarga.cumulativeBytesLoaded / progresoCarga.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      listaDeseos.producto!.productoNombre,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    listaDeseos.producto!.productoPrecio.toCurrency(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Consumer2<ProveedorListaDeseos, ProveedorCarrito>(
                    builder: (context, proveedorListaDeseos, proveedorCarrito, child) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await proveedorListaDeseos.delete(
                                cuentaId: FirebaseAuth.instance.currentUser!.uid,
                                listadeseosId: listaDeseos.listadeseosId,
                              );
                            },
                            icon: const Icon(Icons.delete_rounded),
                          ),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: listaDeseos.producto!.stock > 0
                                ? () async {
                                    String cuentaId = FirebaseAuth.instance.currentUser!.uid;

                                    // Verifica si el producto esta en el carrito
                                    // Si esta añade la cantidad
                                    if (proveedorCarrito.contadorCarrito != 0) {
                                      for (var elemento in proveedorCarrito.listaCarrito) {
                                        if (elemento.productoId == listaDeseos.producto!.productoId) {
                                          Carrito data = elemento;
                                          data.cantidad += 1;
                                          data.total = data.producto!.productoPrecio * data.cantidad;
                                          await proveedorCarrito.updateCarrito(data: data);
                                          return;
                                        }
                                      }
                                    }

                                    // Añade al carrito
                                    Carrito data = Carrito(
                                      carritoId: ''.generateUID(),
                                      producto: listaDeseos.producto,
                                      productoId: listaDeseos.productoId,
                                      cantidad: 1,
                                      total: listaDeseos.producto!.productoPrecio,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    );
                                    await proveedorCarrito.addCarrito(cuentaId: cuentaId, data: data);
                                  }
                                : null,
                            child: listaDeseos.producto!.stock > 0 ? const Text('Añadir al carrito') : const Text('Producto agotado'),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  if (listaDeseos.producto!.rating != 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: ColorPersonalizado.warning,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${listaDeseos.producto!.rating}' ' ' '(${listaDeseos.producto!.reviewsTotal} Revisiones)',
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

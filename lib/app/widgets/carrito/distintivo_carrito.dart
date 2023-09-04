import 'package:badges/badges.dart' as bg;

import 'package:edreams/app/proveedores/proveedor_carrito.dart';
import 'package:edreams/app/proveedores/proveedor_checkout.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/widgets/carrito/contenedor_carrito.dart';
import 'package:edreams/core/dominio/entidades/carrito/carrito.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistintivoCarrito extends StatelessWidget {
  const DistintivoCarrito({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProveedorCarrito>(
      builder: (context, valor, child) {
        if (valor.primeraCarga) {
          return Transform.scale(
            scale: 0.4,
            child: const CircularProgressIndicator(),
          );
        }

        return bg.Badge(
          badgeContent: Text(
            '${valor.contadorCarrito}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          position: bg.BadgePosition.topEnd(),
          badgeStyle: const bg.BadgeStyle(
            badgeColor: ColorPersonalizado.error,
          ),
          showBadge: valor.contadorCarrito != 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Carrito de Compra',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            if (valor.listaCarrito.isEmpty)
                              Text(
                                'El Carrito esta Vacio',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            if (valor.listaCarrito.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ...valor.listaCarrito.map(
                                    (e) => ContenedorCarrito(
                                      objeto: e,
                                      onTapAdd: () {
                                        if (e.cantidad >= e.producto!.stock) return;

                                        Carrito data = e;
                                        data.cantidad += 1;

                                        setState(() {
                                          context.read<ProveedorCarrito>().updateCarrito(data: data);
                                        });
                                      },
                                      onTapRemove: () {
                                        Carrito data = e;
                                        data.cantidad -= 1;

                                        setState(() {
                                          context.read<ProveedorCarrito>().updateCarrito(data: data);
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        valor.total.toCurrency(),
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      var cuenta = context.read<ProveedorCuenta>().cuenta;

                                      var proveedorCheckOut = context.read<ProveedorCheckout>();

                                      proveedorCheckOut.iniciar(carrito: valor.listaCarrito, cuenta: cuenta);

                                      RutaNavegacion.toCheckout(context: context);
                                    },
                                    child: Text('Valor a pagar  (${valor.contadorCarrito.toNumericFormat()})'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.shopping_cart_rounded),
          ),
        );
      },
    );
  }
}

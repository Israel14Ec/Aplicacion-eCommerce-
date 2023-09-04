import 'package:edreams/app/paginas/checkout/widgets/contenedor_producto_checkout.dart';
import 'package:edreams/app/paginas/checkout/widgets/seleccionar_direccion_envio.dart';
import 'package:edreams/app/proveedores/proveedor_checkout.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaCheckout extends StatefulWidget {
  const PaginaCheckout({Key? key}) : super(key: key);

  @override
  State<PaginaCheckout> createState() => _PaginaCheckoutState();
}

class _PaginaCheckoutState extends State<PaginaCheckout> {
  Direccion? direccion;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        direccion = context.read<ProveedorCuenta>().cuenta.direccionPrimaria;
        context.read<ProveedorCheckout>().updateCuentaTotal(direccion: direccion);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caja de pago'),
      ),
      body: Consumer<ProveedorCheckout>(
        builder: (context, valor, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Direccion de envio
                      SeleccionarDireccionEnvio(
                        direccionEnvio: direccion,
                        seleccionarDireccion: () async {
                          var result = await RutaNavegacion.toManejoDireccion(context: context, returnDireccion: true);
                          setState(() {
                            direccion = result;
                            context.read<ProveedorCheckout>().updateCuentaTotal(direccion: direccion);
                          });
                        },
                        removerDireccion: () {
                          setState(() {
                            direccion = null;
                            context.read<ProveedorCheckout>().updateCuentaTotal(direccion: direccion);
                          });
                        },
                      ),

                      // Producto comprado
                      ...valor.dataTransaction.productoComprado.map(
                        (elemento) => ContenedorProductoCheckout(elemento: elemento),
                      ),
                      const SizedBox(height: 8),

                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            valor.dataTransaction.subTotal?.toCurrency() ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Resumen orden
                      Text(
                        'Resumen de la orden',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Precio Total  (${valor.contadorObjetos} Objetos)',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            valor.dataTransaction.precioTotal?.toCurrency() ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      if (direccion != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coste Envio',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              valor.dataTransaction.costeEnvio?.toCurrency() ?? '-',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              // Total de cuenta y metodo de pago
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuenta Total',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          valor.dataTransaction.totalCuenta?.toCurrency() ?? '-',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: ColorPersonalizado.error,
                              ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: direccion == null
                          ? null
                          : () {
                              valor.dataTransaction.direccion = direccion;
                              valor.dataTransaction.totalPagar =
                                  valor.dataTransaction.totalCuenta! + valor.dataTransaction.iva!;

                              RutaNavegacion.toPago(context: context);
                            },
                      child: const Text('Seleccionar Pago'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:edreams/app/paginas/pago/widgets/seleccionar_metodo_pago.dart';
import 'package:edreams/app/proveedores/proveedor_carrito.dart';
import 'package:edreams/app/proveedores/proveedor_checkout.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaPago extends StatefulWidget {
  const PaginaPago({Key? key}) : super(key: key);

  @override
  State<PaginaPago> createState() => _PaginaPagoState();
}

class _PaginaPagoState extends State<PaginaPago> {
  MetodoPago? metodoPago;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        metodoPago = context.read<ProveedorCuenta>().cuenta.metodoPagoPrimario;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago'),
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
                      // Metodo de pago
                      SeleccionarMetodoPago(
                        metodoPago: metodoPago,
                        seleccionarMetodoPago: () async {
                          var resultado =
                              await RutaNavegacion.toManejoMetodoPago(context: context, returnMetodoPago: true);
                          setState(() {
                            metodoPago = resultado;
                          });
                        },
                        removerMetodoPago: () {
                          setState(() {
                            metodoPago = null;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Resumen de pago
                      Text(
                        'Resumen de Pago',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cuenta Total',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            valor.dataTransaction.totalCuenta?.toCurrency() ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'IVA',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            valor.dataTransaction.iva?.toCurrency() ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Pago total
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
                          'Total a Pagar',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          valor.dataTransaction.totalPagar?.toCurrency() ?? '-',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: ColorPersonalizado.error,
                              ),
                        ),
                      ],
                    ),
                    Consumer<ProveedorCheckout>(
                      builder: (context, valor, child) {
                        if (valor.isCargando) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ElevatedButton(
                          onPressed: metodoPago == null
                              ? null
                              : () async {
                                  if (valor.isCargando) return;

                                  try {
                                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                                    valor.dataTransaction.metodoPago = metodoPago;
                                    await valor.checkoutPagar().whenComplete(() {
                                      context
                                          .read<ProveedorCarrito>()
                                          .getCarrito(cuentaId: FirebaseAuth.instance.currentUser!.uid);

                                      Navigator.of(context).popUntil((ruta) => ruta.isFirst);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Transaccion exitosa, revisa el estado de la transaccion en la pagina de transaccion',
                                          ),
                                        ),
                                      );
                                      context.read<ProveedorTransaccion>().cargarTransaccionCuenta();
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                                    ScaffoldMessenger.of(context).showMaterialBanner(
                                      bannerError(context: context, msg: e.toString()),
                                    );
                                  }
                                },
                          child: const Text('Pague aqui su producto'),
                        );
                      },
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

import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/boton_accion_transacciones.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/boton_admin_transaccion_accion.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/columna_resumen_orden.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/columna_resumen_pago.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/detalles_transaccion_producto.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/fecha_compra.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/fila_estado_transaccion.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/fila_subtotal.dart';
import 'package:edreams/app/paginas/transaccion/detalles_transaccion/widgets/informacion_cliente.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaDetalleTransaccion extends StatefulWidget {
  const PaginaDetalleTransaccion({super.key});

  @override
  State<PaginaDetalleTransaccion> createState() => _PaginaDetalleTransaccionState();
}

class _PaginaDetalleTransaccionState extends State<PaginaDetalleTransaccion> {
  FlavorConfig flavor = FlavorConfig.instancia;

  @override
  void initState() {
    Future.microtask(() {
      String transaccionId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<ProveedorTransaccion>().cargarDetallesTransaccion(transaccionId: transaccionId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles Transaccion'),
      ),
      body: Consumer<ProveedorTransaccion>(
        builder: (context, value, child) {
          if (value.isCargandoDetalle) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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
                      // Status & ID
                      FilaEstadoTransaccion(
                        estado: value.detalleTransaccion!.estadoTransaccion!,
                        transaccionID: value.detalleTransaccion!.transaccionId,
                      ),
                      const SizedBox(height: 8),

                      // Fecha de compra
                      FechaCompra(
                        date: value.detalleTransaccion!.createdAt!,
                      ),
                      const SizedBox(height: 12),

                      // Informacion del cliente
                      if (flavor.flavor == Flavor.admin)
                        InformacionCliente(cliente: value.detalleTransaccion!.cuenta!),
                      if (flavor.flavor == Flavor.admin) const SizedBox(height: 12),

                      // Productos adquiridos
                      Text(
                        'Detalles Producto',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      ...value.detalleTransaccion!.productoComprado.map(
                        (objeto) => DetallesTransaccionProducto(objeto: objeto),
                      ),
                      // Subtotal
                      FilaSubtotal(
                        subtotal: value.detalleTransaccion!.subTotal!,
                      ),
                      const SizedBox(height: 16),

                      // Resumen del orden
                      ColumnaResumenOrden(
                        contarObjetos: value.contadorObjetos,
                        precioTotal: value.detalleTransaccion!.precioTotal!,
                        costeEnvio: value.detalleTransaccion!.costeEnvio!,
                        direccion: value.detalleTransaccion!.direccion!,
                      ),
                      const SizedBox(height: 16),

                      // Resumen de pago
                      ColumnaResumenPago(
                        cuentaTotal: value.detalleTransaccion!.totalCuenta!,
                        iva: value.detalleTransaccion!.iva!,
                        pagoTotal: value.detalleTransaccion!.totalPagar!,
                        metodoPago: value.detalleTransaccion!.metodoPago!,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Accion Boton
              flavor.flavor == Flavor.admin
                  ? BotonAdminTransaccionAccion(
                      transaccionID: value.detalleTransaccion!.transaccionId,
                      transaccionEstado: value.detalleTransaccion!.estadoTransaccion!,
                    )
                  : BotonAccionTransaccion(
                      estadoTransaccion: value.detalleTransaccion!.estadoTransaccion!,
                      data: value.detalleTransaccion!,
                    ),
            ],
          );
        },
      ),
    );
  }
}

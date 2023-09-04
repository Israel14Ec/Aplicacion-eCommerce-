import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_metodo_pago.dart';
import 'package:edreams/app/widgets/tarjeta_radio.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/rutas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaManejoMetodoPago extends StatefulWidget {
  const PaginaManejoMetodoPago({Key? key}) : super(key: key);

  @override
  State<PaginaManejoMetodoPago> createState() => _PaginaManejoMetodoPagoState();
}

class _PaginaManejoMetodoPagoState extends State<PaginaManejoMetodoPago> {
  bool returnMetodoPago = false;

  String cuentaId = FirebaseAuth.instance.currentUser!.uid;

  MetodoPago? metodoPagoSeleccionado;

  bool _isCargando = false;

  @override
  void initState() {
    Future.microtask(
      () {
        returnMetodoPago = ModalRoute.of(context)!.settings.arguments as bool;

        metodoPagoSeleccionado = context.read<ProveedorCuenta>().cuenta.metodoPagoPrimario;
        context.read<ProveedorMetodoPago>().getMetodoPagoCuenta(cuentaId: cuentaId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manejo de pago'),
        actions: [
          TextButton(
            onPressed: () {
              RutaNavegacion.toAddMetodoPago(context: context);
            },
            child: const Text('Añadir metodo de pago'),
          ),
        ],
      ),
      body: Consumer<ProveedorMetodoPago>(
        builder: (context, valor, child) {
          if (valor.isCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              // Lista de metodo de pagos
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      if (valor.listaMetodoPago.isEmpty)
                        Center(
                          child: Text(
                            'No hay metodos de pagos,\nAñade un metodo de pago para realizar los pagos',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (valor.listaMetodoPago.isNotEmpty)
                        ...valor.listaMetodoPago.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TarjetaRadio<MetodoPago>(
                              titulo: e.nombreUsuarioTarjeta,
                              subtitulo: e.numeroTarjeta,
                              valor: e,
                              seleccionarValor: metodoPagoSeleccionado,
                              onChanged: (value) {
                                setState(() {
                                  metodoPagoSeleccionado = value;
                                });
                              },
                              onDelete: () {
                                valor.delete(cuentaId: cuentaId, metodoPagoId: e.metodoPagoId);

                                // Si se eliminar el metodo primario
                                if (metodoPagoSeleccionado == e) {
                                  metodoPagoSeleccionado = null;
                                  context.read<ProveedorCuenta>().update(data: {
                                    'metodo_pago_primario': null,
                                  });
                                }
                              },
                              onEdit: () {
                                RutaNavegacion.toEditMetodoPago(context: context, metodoPago: e);
                              },
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),

              // Boton
              if (valor.listaMetodoPago.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: ElevatedButton(
                    onPressed: metodoPagoSeleccionado == null
                        ? null
                        : () async {
                            if (_isCargando) return;

                            if (returnMetodoPago) {
                              Navigator.of(context).pop(metodoPagoSeleccionado);
                              return;
                            }

                            setState(() {
                              _isCargando = true;
                            });

                            MetodoPago? dataAntigua = context.read<ProveedorCuenta>().cuenta.metodoPagoPrimario;
                            await valor
                                .changePrimario(cuentaId: cuentaId, data: metodoPagoSeleccionado!, dataAntigua: dataAntigua)
                                .whenComplete(
                              () async {
                                context.read<ProveedorCuenta>().getPerfil();
                                setState(() {
                                  _isCargando = false;
                                });
                                Navigator.of(context).pop();
                              },
                            );
                          },
                    child: _isCargando
                        ? const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                              ),
                            ),
                          )
                        : returnMetodoPago
                            ? const Text('Seleccionar Metodo de Pago')
                            : const Text('Cambiar Metodo de Pago Primario'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

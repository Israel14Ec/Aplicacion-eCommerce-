import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_direccion.dart';
import 'package:edreams/app/widgets/tarjeta_radio.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/rutas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaManejoDireccion extends StatefulWidget {
  const PaginaManejoDireccion({Key? key}) : super(key: key);

  @override
  State<PaginaManejoDireccion> createState() => _PaginaManejoDireccionState();
}

class _PaginaManejoDireccionState extends State<PaginaManejoDireccion> {
  bool returnDireccion = false;

  String cuentaId = FirebaseAuth.instance.currentUser!.uid;

  Direccion? direccion;

  bool _isCargando = false;

  @override
  void initState() {
    Future.microtask(
      () {
        returnDireccion = ModalRoute.of(context)!.settings.arguments as bool;

        direccion = context.read<ProveedorCuenta>().cuenta.direccionPrimaria;
        context.read<ProveedorDireccion>().getAddress(cuentaId: cuentaId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manejo Direccion'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NombreRutas.kAddDireccion);
            },
            child: const Text('Añadir Direccion'),
          ),
        ],
      ),
      body: Consumer<ProveedorDireccion>(
        builder: (context, valor, child) {
          if (valor.isCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              // Lista de direcciones
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      if (valor.listaDireccion.isEmpty)
                        Center(
                          child: Text(
                            'La direccion esta vacia,\n Añade tu direccion para los envios',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (valor.listaDireccion.isNotEmpty)
                        ...valor.listaDireccion.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TarjetaRadio<Direccion>(
                              titulo: e.nombre,
                              subtitulo: '${e.direccion} ${e.ciudad} ${e.codigoCasa}',
                              valor: e,
                              seleccionarValor: direccion,
                              onChanged: (value) {
                                setState(() {
                                  direccion = value;
                                });
                              },
                              onDelete: () {
                                valor.delete(cuentaId: cuentaId, direccionId: e.direccionId);
                                // If the primary address deleted
                                if (direccion == e) {
                                  direccion = null;
                                  context.read<ProveedorCuenta>().update(data: {
                                    'direccion_primaria': null,
                                  });
                                }
                              },
                              onEdit: () {
                                RutaNavegacion.toEditDireccion(context: context, direccion: e);
                              },
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),

              // Boton
              if (valor.listaDireccion.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: ElevatedButton(
                    onPressed: direccion == null
                        ? null
                        : () async {
                            if (_isCargando) return;

                            if (returnDireccion) {
                              Navigator.of(context).pop(direccion);
                              return;
                            }

                            setState(() {
                              _isCargando = true;
                            });

                            Direccion? dataAntigua = context.read<ProveedorCuenta>().cuenta.direccionPrimaria;
                            await valor
                                .changePrimaria(cuentaId: cuentaId, data: direccion!, dataAntigua: dataAntigua)
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
                        : returnDireccion
                            ? const Text('Seleccionar direccion')
                            : const Text('Cambiar direccion primaria'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

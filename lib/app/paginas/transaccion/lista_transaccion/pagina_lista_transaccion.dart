import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/app/paginas/transaccion/lista_transaccion/widgets/contenedor_transaccion.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/app/widgets/app_bar_search.dart';
import 'package:edreams/app/widgets/contador_y_opciones.dart';
import 'package:edreams/app/widgets/ficha_orden_filtrado.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaListaTransaccion extends StatefulWidget {
  const PaginaListaTransaccion({Key? key}) : super(key: key);

  @override
  State<PaginaListaTransaccion> createState() => _PaginaListaTransaccionState();
}

class _PaginaListaTransaccionState extends State<PaginaListaTransaccion> {
  // Flavor
  FlavorConfig flavor = FlavorConfig.instancia;

  // Controlador TextEditing
  final TextEditingController _txtBusqueda = TextEditingController();

  // Orden
  OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo;
  OrdenarPorValor ordenarPorValue = getEnumValor(OrdenarPorEnum.nuevo);

  // Search
  String busqueda = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // AppBar de busqueda
      appBar: AppBarBusqueda(
        onChanged: (valor) {
          busqueda = valor!;
          if (flavor.flavor == Flavor.admin) {
            context.read<ProveedorTransaccion>().cargarTodasTransaccion(
                  busqueda: busqueda,
                  ordenarPorEnum: ordenarPorEnum,
                );
          } else {
            context.read<ProveedorTransaccion>().cargarTransaccionCuenta(
                  busqueda: busqueda,
                  ordenarPorEnum: ordenarPorEnum,
                );
          }
        },
        controlador: _txtBusqueda,
        textoSugerencia: 'Buscar transaccion del producto',
      ),
      body: Consumer<ProveedorTransaccion>(
        builder: (context, value, child) {
          if (value.isCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              children: [
                // Contador de productos y filtros
                ContadorYOpciones(
                  contador: value.listaTransaccion.length,
                  nombreObjeto: 'Transaction',
                  isOrdenada: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return FichaOrdenFiltrado(
                              dataEnum: OrdenarPorEnum.values.take(4).toList(),
                              onSelected: (valor) {
                                setState(() {
                                  ordenarPorEnum = valor;
                                  ordenarPorValue = getEnumValor(valor);
                                  if (flavor.flavor == Flavor.admin) {
                                    context.read<ProveedorTransaccion>().cargarTodasTransaccion(
                                          busqueda: busqueda,
                                          ordenarPorEnum: ordenarPorEnum,
                                        );
                                  } else {
                                    context.read<ProveedorTransaccion>().cargarTransaccionCuenta(
                                          busqueda: busqueda,
                                          ordenarPorEnum: ordenarPorEnum,
                                        );
                                  }
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

                // Lista de productos
                if (value.listaTransaccion.isEmpty && _txtBusqueda.text.isEmpty)
                  const Center(
                    child: Text(
                      'No hay transacciones disponibles,\nRealiza tu primer transaccion',
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (value.listaTransaccion.isEmpty && _txtBusqueda.text.isNotEmpty)
                  const Center(
                    child: Text('Transaccion no encontrada'),
                  ),

                if (value.listaTransaccion.isNotEmpty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        if (flavor.flavor == Flavor.admin) {
                          value.cargarTodasTransaccion(
                            busqueda: busqueda,
                            ordenarPorEnum: ordenarPorEnum,
                          );
                        } else {
                          value.cargarTransaccionCuenta(
                            busqueda: busqueda,
                            ordenarPorEnum: ordenarPorEnum,
                          );
                        }
                      },
                      child: ListView.builder(
                        itemCount: value.listaTransaccion.length,
                        itemBuilder: (_, indice) {
                          final objeto = value.listaTransaccion[indice];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ContenedorTransaccion(objeto: objeto),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

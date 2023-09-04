import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/app/proveedores/proveedor_producto.dart';
import 'package:edreams/app/widgets/app_bar_search.dart';
import 'package:edreams/app/widgets/contador_y_opciones.dart';
import 'package:edreams/app/widgets/ficha_orden_filtrado.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/rutas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/contenedor_producto.dart';

class PaginaListaProducto extends StatefulWidget {
  const PaginaListaProducto({Key? key}) : super(key: key);

  @override
  State<PaginaListaProducto> createState() => _PaginaListaProductoState();
}

class _PaginaListaProductoState extends State<PaginaListaProducto> {
  // Flavor
  FlavorConfig flavor = FlavorConfig.instancia;

  // Controlador TextEditing
  final TextEditingController _txtBusqueda = TextEditingController();

  // Ordenar
  OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo;
  OrdenarPorValor orderByValue = getEnumValor(OrdenarPorEnum.nuevo);

  // Busqueda
  String busqueda = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: flavor.flavor == Flavor.admin
          ? FloatingActionButton(
              onPressed: () {
                RutaNavegacion.toAddProducto(context: context);
              },
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
            )
          : null,
      // App Bar Search
      appBar: AppBarBusqueda(
        onChanged: (valor) {
          busqueda = valor!;
          context.read<ProveedorProducto>().cargarListaProducto(
                busqueda: busqueda,
                ordenarPorEnum: ordenarPorEnum,
              );
        },
        controlador: _txtBusqueda,
        textoSugerencia: 'Buscar Producto',
      ),
      body: Consumer<ProveedorProducto>(
        builder: (context, valor, child) {
          if (valor.isCargando) {
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
                // Product Count & Filter
                ContadorYOpciones(
                  contador: valor.listaProducto.length,
                  nombreObjeto: 'Productos',
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
                                  orderByValue = getEnumValor(valor);
                                  context.read<ProveedorProducto>().cargarListaProducto(
                                        busqueda: _txtBusqueda.text,
                                        ordenarPorEnum: ordenarPorEnum,
                                      );
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

                // Lista de producto
                if (valor.listaProducto.isEmpty && _txtBusqueda.text.isEmpty)
                  const Center(
                    child: Text(
                      'No hay productos,\nlos productos disponibles se veran aqui',
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (valor.listaProducto.isEmpty && _txtBusqueda.text.isNotEmpty)
                  const Center(
                    child: Text('Productos no encontrados'),
                  ),

                if (valor.listaProducto.isNotEmpty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await valor.cargarListaProducto(
                          busqueda: busqueda,
                          ordenarPorEnum: ordenarPorEnum,
                        );
                      },
                      child: GridView.builder(
                        itemCount: valor.listaProducto.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio:
                              MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
                        ),
                        itemBuilder: (_, indice) {
                          final objeto = valor.listaProducto[indice];

                          return ContenedorProducto(
                            objeto: objeto,
                            onTap: () {
                              RutaNavegacion.toDetallesProducto(context: context, productoId: objeto.productoId);
                            },
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

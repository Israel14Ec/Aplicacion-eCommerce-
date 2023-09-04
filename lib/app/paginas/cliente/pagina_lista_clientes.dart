import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/app/paginas/cliente/widgets/contenedor_cliente.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar_search.dart';
import '../../widgets/contador_y_opciones.dart';
import '../../widgets/ficha_orden_filtrado.dart';

class PaginaListaClientes extends StatefulWidget {
  const PaginaListaClientes({Key? key}) : super(key: key);

  @override
  State<PaginaListaClientes> createState() => _PaginaListaClientesState();
}

class _PaginaListaClientesState extends State<PaginaListaClientes> {
  // Controlador TextEditing
  final TextEditingController _txtBusqueda = TextEditingController();

  // Ordenar
  OrdenarPorEnum ordenarPorEnum = OrdenarPorEnum.nuevo;
  OrdenarPorValor ordenarPorValue = getEnumValor(OrdenarPorEnum.nuevo);

  // Busqueda
  String busqueda = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar Search
      appBar: AppBarBusqueda(
        onChanged: (value) {
          context.read<ProveedorCuenta>().getListaCuenta(
                busqueda: _txtBusqueda.text,
                ordenarPorEnum: ordenarPorEnum,
              );
        },
        controlador: _txtBusqueda,
        textoSugerencia: 'Buscar Usuario',
      ),
      body: Consumer<ProveedorCuenta>(
        builder: (context, valor, child) {
          if (valor.isListaCuentasCargada) {
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
                // Contador de productos y filtro
                ContadorYOpciones(
                  contador: valor.listaCuenta.length,
                  nombreObjeto: 'Cliente',
                  isOrdenada: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return FichaOrdenFiltrado(
                              dataEnum: OrdenarPorEnum.values.take(2).toList(),
                              onSelected: (valor) {
                                setState(() {
                                  ordenarPorEnum = valor;
                                  ordenarPorValue = getEnumValor(valor);
                                  context.read<ProveedorCuenta>().getListaCuenta(
                                        busqueda: _txtBusqueda.text,
                                        ordenarPorEnum: valor,
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

                // Lista Productos
                if (valor.listaCuenta.isEmpty && _txtBusqueda.text.isEmpty)
                  const Center(
                    child: Text(
                      "La lista de clientes esta vacia,\nlos clientes apareceran aqui",
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (valor.listaCuenta.isEmpty && _txtBusqueda.text.isNotEmpty)
                  const Center(
                    child: Text('Cliente no encontrado'),
                  ),
                
                if (valor.listaCuenta.isNotEmpty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await context.read<ProveedorCuenta>().getListaCuenta(
                              busqueda: _txtBusqueda.text,
                              ordenarPorEnum: ordenarPorEnum,
                            );
                      },
                      child: ListView.builder(
                        itemCount: valor.listaCuenta.length,
                        itemBuilder: (_, indice) {
                          final customer = valor.listaCuenta[indice];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ContenedorCliente(cliente: customer),
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

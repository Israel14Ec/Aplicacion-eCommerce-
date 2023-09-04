import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:edreams/app/paginas/lista_deseos/widgets/contenedor_lista_deseos.dart';
import 'package:edreams/app/proveedores/proveedor_lista_deseos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar_search.dart';
import '../../widgets/contador_y_opciones.dart';
import '../../widgets/ficha_orden_filtrado.dart';

class PaginaListaDeseos extends StatefulWidget {
  const PaginaListaDeseos({Key? key}) : super(key: key);

  @override
  State<PaginaListaDeseos> createState() => _PaginaListaDeseosState();
}

class _PaginaListaDeseosState extends State<PaginaListaDeseos> {
  String cuentaId = FirebaseAuth.instance.currentUser!.uid;

  // Controlador TextEditing
  final TextEditingController _txtBusqueda = TextEditingController();

  // Orden en la sala
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
      // AppBar de busqueda
      appBar: AppBarBusqueda(
        onChanged: (valor) {
          context.read<ProveedorListaDeseos>().cargarListaDeseos(
                cuentaId: cuentaId,
                busqueda: _txtBusqueda.text,
                ordenarPorEnum: ordenarPorEnum,
              );
        },
        controlador: _txtBusqueda,
        textoSugerencia: 'Buscar en la lista de deseos',
      ),
      body: Consumer<ProveedorListaDeseos>(
        builder: (context, valor, child) {
          if (valor.isDataCargada) {
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
                  contador: valor.listListaDeseos.length,
                  nombreObjeto: 'Lista de Deseos',
                  isOrdenada: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return FichaOrdenFiltrado(
                              dataEnum: OrdenarPorEnum.values.take(4).toList(),
                              onSelected: (value) {
                                setState(() {
                                  ordenarPorEnum = value;
                                  ordenarPorValue = getEnumValor(value);
                                  context.read<ProveedorListaDeseos>().cargarListaDeseos(
                                        cuentaId: cuentaId,
                                        busqueda: _txtBusqueda.text,
                                        ordenarPorEnum: value,
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

                // Lista de productos
                if (valor.listListaDeseos.isEmpty && _txtBusqueda.text.isEmpty)
                  const Center(
                    child: Text(
                      'La lista de deseos esta vacia,\nsu lista de deseos se mostrara aqui',
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (valor.listListaDeseos.isEmpty && _txtBusqueda.text.isNotEmpty)
                  const Center(
                    child: Text('Lista de deseos no encontrada'),
                  ),

                if (valor.listListaDeseos.isNotEmpty)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await context.read<ProveedorListaDeseos>().cargarListaDeseos(
                              cuentaId: cuentaId,
                              busqueda: _txtBusqueda.text,
                              ordenarPorEnum: ordenarPorEnum,
                            );
                      },
                      child: ListView.builder(
                        itemCount: valor.listListaDeseos.length,
                        itemBuilder: (_, indice) {
                          final item = valor.listListaDeseos[indice];

                          return ContenedorListaDeseos(
                            listaDeseos: item,
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

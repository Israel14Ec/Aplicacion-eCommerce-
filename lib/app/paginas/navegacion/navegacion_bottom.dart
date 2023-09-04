import 'package:edreams/app/paginas/cliente/pagina_lista_clientes.dart';
import 'package:edreams/app/paginas/lista_deseos/pagina_lista_deseos.dart';
import 'package:edreams/app/paginas/perfil/pagina_perfil.dart';
import 'package:edreams/app/paginas/producto/lista_producto/pagina_lista_producto.dart';
import 'package:edreams/app/paginas/transaccion/lista_transaccion/pagina_lista_transaccion.dart';
import 'package:edreams/app/proveedores/proveedor_carrito.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_lista_deseos.dart';
import 'package:edreams/app/proveedores/proveedor_producto.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavegacionBottom extends StatefulWidget {
  const NavegacionBottom({Key? key}) : super(key: key);

  @override
  State<NavegacionBottom> createState() => _NavegacionBottomState();
}

class _NavegacionBottomState extends State<NavegacionBottom> {
  // Indice actual de navegacion
  int _indiceActual = 0;

  // Pantalla para navegacion
  final List<Widget> _buildScreens = [];

  // Objetos de navegacion
  final List<NavigationDestination> _destinos = [];

  // Flavor
  FlavorConfig flavor = FlavorConfig.instancia;

  @override
  void initState() {
    _destinos.add(
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        label: 'Inicio',
        selectedIcon: Icon(Icons.home_rounded),
      ),
    );

    _buildScreens.add(const PaginaListaProducto());

    if (flavor.flavor == Flavor.usuario) {
      _destinos.addAll([
        const NavigationDestination(
          icon: Icon(Icons.favorite_outline_rounded),
          label: 'Lista de Deseos',
          selectedIcon: Icon(Icons.favorite_rounded),
        ),
        const NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          label: 'Transaccion',
          selectedIcon: Icon(Icons.receipt_long_rounded),
        ),
      ]);
      _buildScreens.addAll([
        const PaginaListaDeseos(),
        const PaginaListaTransaccion(),
      ]);
    } else {
      _destinos.addAll([
        const NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          label: 'Transaccion',
          selectedIcon: Icon(Icons.receipt_long_rounded),
        ),
        const NavigationDestination(
          icon: Icon(Icons.group_outlined),
          label: 'Cliente',
          selectedIcon: Icon(Icons.group_rounded),
        ),
      ]);
      _buildScreens.addAll([
        const PaginaListaTransaccion(),
        const PaginaListaClientes(),
      ]);
    }

    _buildScreens.add(const PaginaPerfil());
    _destinos.add(
      const NavigationDestination(
        icon: Icon(Icons.person_outline),
        label: 'Perfil',
        selectedIcon: Icon(Icons.person_rounded),
      ),
    );

    Future.microtask(
      () {
        String cuentaId = FirebaseAuth.instance.currentUser!.uid;
        context.read<ProveedorProducto>().cargarListaProducto();
        context.read<ProveedorCarrito>().getCarrito(cuentaId: cuentaId);
        if (flavor.flavor == Flavor.usuario) {
          context.read<ProveedorListaDeseos>().cargarListaDeseos(cuentaId: cuentaId);
          context.read<ProveedorTransaccion>().cargarTransaccionCuenta();
        } else {
          context.read<ProveedorTransaccion>().cargarTodasTransaccion();
          context.read<ProveedorCuenta>().getListaCuenta();
        }
        context.read<ProveedorCuenta>().getPerfil();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[_indiceActual],
      bottomNavigationBar: NavigationBar(
        destinations: _destinos,
        selectedIndex: _indiceActual,
        onDestinationSelected: (int indice) {
          setState(() {
            _indiceActual = indice;
          });
        },
      ),
    );
  }
}

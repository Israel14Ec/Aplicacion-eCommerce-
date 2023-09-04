import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/app/paginas/auten/login/pagina_login.dart';
import 'package:edreams/app/paginas/navegacion/navegacion_bottom.dart';
import 'package:edreams/app/proveedores/proveedor_auten.dart';
import 'package:edreams/app/proveedores/proveedor_carrito.dart';
import 'package:edreams/app/proveedores/proveedor_checkout.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_direccion.dart';
import 'package:edreams/app/proveedores/proveedor_lista_deseos.dart';
import 'package:edreams/app/proveedores/proveedor_metodo_pago.dart';
import 'package:edreams/app/proveedores/proveedor_modo_oscuro.dart';
import 'package:edreams/app/proveedores/proveedor_producto.dart';
import 'package:edreams/app/proveedores/proveedor_transaccion.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/login_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/logout_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/registrar_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/add_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/delete_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/get_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/carrito/update_carrito_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/checkout/iniciar_checkout.dart';
import 'package:edreams/core/dominio/casosdeuso/checkout/pagar.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/ban_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/get_perfil_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/get_todas_cuentas.dart';
import 'package:edreams/core/dominio/casosdeuso/cuenta/update_account.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/add_direccion.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/change_direccion_primaria.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/delete_direccion.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/get_direccion_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/update_direccion.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/add_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/delete_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/get_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/add_metodo_pago.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/change_metodo_pago_primario.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/delete_metodo_pago.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/get_metodo_pago_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/update_metodo_pago.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/add_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/delete_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_lista_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/get_producto_review.dart';
import 'package:edreams/core/dominio/casosdeuso/producto/update_producto.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/aceptar_transaccion.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/add_review.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/change_estado_transaccion.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/get_cuenta_transacciones.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/get_todas_transacciones.dart';
import 'package:edreams/core/dominio/casosdeuso/transaccion/get_transaccion.dart';
import 'package:edreams/core/repositorios/repositorio_auten_impl.dart';
import 'package:edreams/core/repositorios/repositorio_carrito_impl.dart';
import 'package:edreams/core/repositorios/repositorio_checkout_impl.dart';
import 'package:edreams/core/repositorios/repositorio_cuenta_impl.dart';
import 'package:edreams/core/repositorios/repositorio_direccion_impl.dart';
import 'package:edreams/core/repositorios/repositorio_lista_deseos_impl.dart';
import 'package:edreams/core/repositorios/repositorio_metodo_pago_impl.dart';
import 'package:edreams/core/repositorios/repositorio_producto_impl.dart';
import 'package:edreams/core/repositorios/repositorio_transaccion_impl.dart';
import 'package:edreams/rutas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Collection Reference
  final CollectionReference _cuentaCollection = FirebaseFirestore.instance.collection(ColeccionNombre.kCUENTA);
  final CollectionReference _productoCollection = FirebaseFirestore.instance.collection(ColeccionNombre.kPRODUCTO);
  final CollectionReference _transaccionCollection =
      FirebaseFirestore.instance.collection(ColeccionNombre.kTRANSACCION);

  // Repositorio Impl
  late RepositorioAutenImpl _repositorioAutenImpl;
  late RepositorioCuentaImpl _repositorioCuentaImpl;
  late RepositorioProductoImpl _repositorioProductoImpl;
  late RepositorioCarritoImpl _repositorioCarritoImpl;
  late RepositorioListaDeseosImpl _repositorioListaDeseosImpl;
  late RepositorioDireccionImpl _repositorioDireccionImpl;
  late RepositorioMetodoPagoImpl _repositorioMetodoPagoImpl;
  late RepositorioCheckoutImpl _repositorioCheckoutImpl;
  late RepositorioTransaccionImpl _repositorioTransaccionImpl;

  @override
  void initState() {
    _repositorioAutenImpl = RepositorioAutenImpl(auth: FirebaseAuth.instance, collectionReference: _cuentaCollection);
    _repositorioCuentaImpl = RepositorioCuentaImpl(collectionReference: _cuentaCollection);
    _repositorioProductoImpl = RepositorioProductoImpl(collectionReference: _productoCollection);
    _repositorioCarritoImpl = RepositorioCarritoImpl(collectionReference: _cuentaCollection);
    _repositorioListaDeseosImpl = RepositorioListaDeseosImpl(collectionReference: _cuentaCollection);
    _repositorioDireccionImpl = RepositorioDireccionImpl(collectionReference: _cuentaCollection);
    _repositorioMetodoPagoImpl = RepositorioMetodoPagoImpl(collectionReference: _cuentaCollection);
    _repositorioCheckoutImpl = RepositorioCheckoutImpl(collectionReference: _transaccionCollection);
    _repositorioTransaccionImpl = RepositorioTransaccionImpl(collectionReference: _transaccionCollection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProveedorAuten(
            loginCuenta: LoginCuenta(_repositorioAutenImpl),
            registrarCuenta: RegistrarCuenta(_repositorioAutenImpl),
            logoutCuenta: LogoutCuenta(_repositorioAutenImpl),
          )..isLoggedIn(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorModoOscuro()..getModoOscuro(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorCuenta(
            getPerfilCuenta: GetPerfilCuenta(_repositorioCuentaImpl),
            getTodasCuentas: GetTodasCuentas(_repositorioCuentaImpl),
            updateCuenta: UpdateCuenta(_repositorioCuentaImpl),
            banCuenta: BanCuenta(_repositorioCuentaImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorProducto(
            getListaProducto: GetListaProducto(_repositorioProductoImpl),
            getProducto: GetProducto(_repositorioProductoImpl),
            getProductoReview: GetProductoReview(_repositorioProductoImpl),
            addProducto: AddProducto(_repositorioProductoImpl),
            updateProducto: UpdateProducto(_repositorioProductoImpl),
            deleteProducto: DeleteProducto(_repositorioProductoImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorCarrito(
            addCarritoCuenta: AddCarritoCuenta(_repositorioCarritoImpl),
            getCarritoCuenta: GetCarritoCuenta(_repositorioCarritoImpl),
            updateCarritoCuenta: UpdateCarritoCuenta(_repositorioCarritoImpl),
            deleteCuentaCarrito: DeleteCuentaCarrito(_repositorioCarritoImpl),
            getProducto: GetProducto(_repositorioProductoImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorListaDeseos(
            addListaDeseosCuenta: AddListaDeseosCuenta(_repositorioListaDeseosImpl),
            getListaDeseosCuenta: GetListaDeseosCuenta(_repositorioListaDeseosImpl),
            deleteListaDeseosCuenta: DeleteListaDeseosCuenta(_repositorioListaDeseosImpl),
            getProducto: GetProducto(_repositorioProductoImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorDireccion(
            addDireccion: AddDireccion(_repositorioDireccionImpl),
            getDireccionCuenta: GetDireccionCuenta(_repositorioDireccionImpl),
            updateDireccion: UpdateDireccion(_repositorioDireccionImpl),
            deleteDireccion: DeleteDireccion(_repositorioDireccionImpl),
            changeDireccionPrimaria: ChangeDireccionPrimaria(_repositorioDireccionImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorMetodoPago(
            addMetodoPago: AddMetodoPago(_repositorioMetodoPagoImpl),
            getMetodoPago: GetMetodoPago(_repositorioMetodoPagoImpl),
            updateMetodoPago: UpdateMetodoPago(_repositorioMetodoPagoImpl),
            deleteMetodoPago: DeleteMetodoPago(_repositorioMetodoPagoImpl),
            changeMetodoPagoPrimario: ChangeMetodoPagoPrimario(_repositorioMetodoPagoImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorCheckout(
            iniciarCheckout: IniciarCheckout(_repositorioCheckoutImpl),
            pagar: Pagar(_repositorioCheckoutImpl),
            updateProducto: UpdateProducto(_repositorioProductoImpl),
            deleteCuentaCarrito: DeleteCuentaCarrito(_repositorioCarritoImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorTransaccion(
            getCuentaTransaccion: GetCuentaTransaccion(_repositorioTransaccionImpl),
            getTransaccion: GetTransaccion(_repositorioTransaccionImpl),
            getTodasTransacciones: GetTodasTransacciones(_repositorioTransaccionImpl),
            acceptTransaccion: AceptarTransaccion(_repositorioTransaccionImpl),
            addReview: AddReview(_repositorioTransaccionImpl),
            changeEstadoTransaccion: ChangeEstadoTransaccion(_repositorioTransaccionImpl),
            getPerfilCuenta: GetPerfilCuenta(_repositorioCuentaImpl),
          ),
        ),
      ],
      child: Consumer<ProveedorModoOscuro>(
        builder: (context, modoOscuro, child) {
          return MaterialApp(
            title: FlavorConfig.instancia.flavorValores.rolConfig.appNombre(),
            theme: FlavorConfig.instancia.flavorValores.rolConfig.tema(),
            darkTheme: FlavorConfig.instancia.flavorValores.rolConfig.temaOscuro(),
            themeMode: modoOscuro.isModoOscuro ? ThemeMode.dark : ThemeMode.light,
            routes: rutas,
            debugShowCheckedModeBanner: false,
            home: Consumer<ProveedorAuten>(
              child: const NavegacionBottom(),
              builder: (context, auth, child) {
                if (auth.checkUsuario || modoOscuro.isCargando) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (auth.isUsuarioLoggedIn) {
                  return child!;
                }

                return const PaginaLogin();
              },
            ),
          );
        },
      ),
    );
  }
}

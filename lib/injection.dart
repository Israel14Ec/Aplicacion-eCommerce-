import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edreams/app/constantes/coleccion_nombre.dart';
import 'package:edreams/core/dominio/casosdeuso/auten/login_cuenta.dart';
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
import 'package:edreams/core/dominio/casosdeuso/direccion/get_direccion_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/direccion/update_direccion.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/add_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/delete_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/lista_deseos/get_lista_deseos_cuenta.dart';
import 'package:edreams/core/dominio/casosdeuso/metoodo_pago/add_metodo_pago.dart';
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
import 'package:edreams/core/dominio/repositorios/repositorio__carrito.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_auten.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_checkout.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_cuenta.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_direccion.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_lista_deseos.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_metodo_pago.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_producto.dart';
import 'package:edreams/core/dominio/repositorios/repositorio_transaccion.dart';
import 'package:edreams/core/repositorios/repositorio_auten_impl.dart';
import 'package:edreams/core/repositorios/repositorio_carrito_impl.dart';
import 'package:edreams/core/repositorios/repositorio_checkout_impl.dart';
import 'package:edreams/core/repositorios/repositorio_cuenta_impl.dart';
import 'package:edreams/core/repositorios/repositorio_direccion_impl.dart';
import 'package:edreams/core/repositorios/repositorio_lista_deseos_impl.dart';
import 'package:edreams/core/repositorios/repositorio_metodo_pago_impl.dart';
import 'package:edreams/core/repositorios/repositorio_producto_impl.dart';
import 'package:edreams/core/repositorios/repositorio_transaccion_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// Firestore Top Collection Reference
final cuentaCollection = FirebaseFirestore.instance.collection(ColeccionNombre.kCUENTA);
final productoCollection = FirebaseFirestore.instance.collection(ColeccionNombre.kPRODUCTO);
final transaccionCollection = FirebaseFirestore.instance.collection(ColeccionNombre.kTRANSACCION);

void setup() {
  // Repositories
  getIt.registerLazySingleton<RepositorioCuenta>(
    () => RepositorioCuentaImpl(collectionReference: cuentaCollection),
  );

  getIt.registerLazySingleton<RepositorioDireccion>(
    () => RepositorioDireccionImpl(collectionReference: cuentaCollection),
  );

  getIt.registerLazySingleton<RepositorioAuten>(
    () => RepositorioAutenImpl(auth: FirebaseAuth.instance, collectionReference: cuentaCollection),
  );

  getIt.registerLazySingleton<RepositorioCarrito>(
    () => RepositorioCarritoImpl(collectionReference: cuentaCollection),
  );

  getIt.registerLazySingleton<RepositorioCheckout>(
    () => RepositorioCheckoutImpl(collectionReference: transaccionCollection),
  );

  getIt.registerLazySingleton<RepositorioMetodoPago>(
    () => RepositorioMetodoPagoImpl(collectionReference: cuentaCollection),
  );

  getIt.registerLazySingleton<RepositorioProducto>(
    () => RepositorioProductoImpl(collectionReference: productoCollection),
  );

  getIt.registerLazySingleton<RepositorioTransaccion>(
    () => RepositorioTransaccionImpl(collectionReference: transaccionCollection),
  );

  getIt.registerLazySingleton<RepositorioListaDeseos>(
    () => RepositorioListaDeseosImpl(collectionReference: cuentaCollection),
  );
  // END

  // Casos de uso

  // Casos de uso cuenta
  getIt.registerLazySingleton<BanCuenta>(
    () => BanCuenta(getIt<RepositorioCuenta>()),
  );
  getIt.registerLazySingleton<GetPerfilCuenta>(
    () => GetPerfilCuenta(getIt<RepositorioCuenta>()),
  );
  getIt.registerLazySingleton<GetPerfilCuenta>(
    () => GetPerfilCuenta(getIt<RepositorioCuenta>()),
  );
  getIt.registerLazySingleton<GetTodasCuentas>(
    () => GetTodasCuentas(getIt<RepositorioCuenta>()),
  );
  getIt.registerLazySingleton<UpdateCuenta>(
    () => UpdateCuenta(getIt<RepositorioCuenta>()),
  );

  // Casos de uso direccion
  getIt.registerLazySingleton<AddDireccion>(
    () => AddDireccion(getIt<RepositorioDireccion>()),
  );
  getIt.registerLazySingleton<GetDireccionCuenta>(
    () => GetDireccionCuenta(getIt<RepositorioDireccion>()),
  );
  getIt.registerLazySingleton<UpdateDireccion>(
    () => UpdateDireccion(getIt<RepositorioDireccion>()),
  );

  // Autenticacion casos de uso
  getIt.registerLazySingleton<LoginCuenta>(
    () => LoginCuenta(getIt<RepositorioAuten>()),
  );
  getIt.registerLazySingleton<RegistrarCuenta>(
    () => RegistrarCuenta(getIt<RepositorioAuten>()),
  );

  // Carrito casos de uso
  getIt.registerLazySingleton<AddCarritoCuenta>(
    () => AddCarritoCuenta(getIt<RepositorioCarrito>()),
  );
  getIt.registerLazySingleton<DeleteCuentaCarrito>(
    () => DeleteCuentaCarrito(getIt<RepositorioCarrito>()),
  );
  getIt.registerLazySingleton<GetCarritoCuenta>(
    () => GetCarritoCuenta(getIt<RepositorioCarrito>()),
  );
  getIt.registerLazySingleton<UpdateCarritoCuenta>(
    () => UpdateCarritoCuenta(getIt<RepositorioCarrito>()),
  );

  // Checkout casos de uso, se evapora
  getIt.registerLazySingleton<Pagar>(
    () => Pagar(getIt<RepositorioCheckout>()),
  );
  getIt.registerLazySingleton<IniciarCheckout>(
    () => IniciarCheckout(getIt<RepositorioCheckout>()),
  );

  // Payment Method Use Cases
  getIt.registerLazySingleton<AddMetodoPago>(
    () => AddMetodoPago(getIt<RepositorioMetodoPago>()),
  );
  getIt.registerLazySingleton<DeleteMetodoPago>(
    () => DeleteMetodoPago(getIt<RepositorioMetodoPago>()),
  );
  getIt.registerLazySingleton<GetMetodoPago>(
    () => GetMetodoPago(getIt<RepositorioMetodoPago>()),
  );
  getIt.registerLazySingleton<UpdateMetodoPago>(
    () => UpdateMetodoPago(getIt<RepositorioMetodoPago>()),
  );

  // Product Use Cases, mi chica de humo
  getIt.registerLazySingleton<AddProducto>(
    () => AddProducto(getIt<RepositorioProducto>()),
  );
  getIt.registerLazySingleton<DeleteProducto>(
    () => DeleteProducto(getIt<RepositorioProducto>()),
  );
  getIt.registerLazySingleton<GetListaProducto>(
    () => GetListaProducto(getIt<RepositorioProducto>()),
  );
  getIt.registerLazySingleton<GetProductoReview>(
    () => GetProductoReview(getIt<RepositorioProducto>()),
  );
  getIt.registerLazySingleton<GetProducto>(
    () => GetProducto(getIt<RepositorioProducto>()),
  );
  getIt.registerLazySingleton<UpdateProducto>(
    () => UpdateProducto(getIt<RepositorioProducto>()),
  );

  // Transaccion casos de uso
  getIt.registerLazySingleton<AceptarTransaccion>(
    () => AceptarTransaccion(getIt<RepositorioTransaccion>()),
  );
  getIt.registerLazySingleton<AddReview>(
    () => AddReview(getIt<RepositorioTransaccion>()),
  );
  getIt.registerLazySingleton<ChangeEstadoTransaccion>(
    () => ChangeEstadoTransaccion(getIt<RepositorioTransaccion>()),
  );
  getIt.registerLazySingleton<GetCuentaTransaccion>(
    () => GetCuentaTransaccion(getIt<RepositorioTransaccion>()),
  );
  getIt.registerLazySingleton<GetTodasTransacciones>(
    () => GetTodasTransacciones(getIt<RepositorioTransaccion>()),
  );
  getIt.registerLazySingleton<GetTransaccion>(
    () => GetTransaccion(getIt<RepositorioTransaccion>()),
  );

  // Lista de deseos casos de uso
  getIt.registerLazySingleton<AddListaDeseosCuenta>(
    () => AddListaDeseosCuenta(getIt<RepositorioListaDeseos>()),
  );
  getIt.registerLazySingleton<DeleteListaDeseosCuenta>(
    () => DeleteListaDeseosCuenta(getIt<RepositorioListaDeseos>()),
  );
  getIt.registerLazySingleton<GetListaDeseosCuenta>(
    () => GetListaDeseosCuenta(getIt<RepositorioListaDeseos>()),
  );
}

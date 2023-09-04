import 'package:json_annotation/json_annotation.dart';

import '../carrito/carrito.dart';
import '../cuenta/cuenta.dart';
import '../direccion/direccion.dart';
import '../metodo_pago/metodo_pago.dart';

part 'transaccion.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaccion {
  @JsonKey(name: 'transaccion_id')
  String transaccionId;

  @JsonKey(name: 'cuenta_id')
  String cuentaId;

  @JsonKey(name: 'cuenta')
  Cuenta? cuenta;

  @JsonKey(name: 'direccion')
  Direccion? direccion;

  @JsonKey(name: 'producto_comprado')
  List<Carrito>  productoComprado;

  @JsonKey(name: 'sub_total')
  double? subTotal = 0;

  @JsonKey(name: 'precio_total')
  double? precioTotal = 0;

  @JsonKey(name: 'coste_envio')
  double? costeEnvio = 0;

  @JsonKey(name: 'metodo_pago')
  MetodoPago? metodoPago;

  @JsonKey(name: 'total_cuenta')
  double? totalCuenta = 0;

  @JsonKey(name: 'iva')
  double? iva = 0;

  @JsonKey(name: 'total_pagar')
  double? totalPagar = 0;

  @JsonKey(name: 'estado_transaccion')
  int? estadoTransaccion = 0; // 0: Procesado, 1: Enviado, 2: Entregado, 3: Recibido, 4: Cancelado

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Transaccion({
    required this.transaccionId,
    required this.cuentaId,
    required this.productoComprado,
    this.cuenta,
    this.direccion,
    this.subTotal,
    this.precioTotal,
    this.costeEnvio,
    this.metodoPago,
    this.totalCuenta,
    this.iva,
    this.totalPagar,
    this.estadoTransaccion,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaccion.fromJson(Map<String, dynamic> json) => _$TransaccionFromJson(json);

  Map<String, dynamic> toJson() => _$TransaccionToJson(this);
}

enum EstadoTransaccion {
  procesado(0),
  enviado(1),
  entregado(2),
  recibido(3),
  rechazado(4),
  calificado(5);

  final int valor;
  const EstadoTransaccion(this.valor);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaccion _$TransaccionFromJson(Map<String, dynamic> json) => Transaccion(
      transaccionId: json['transaccion_id'] as String,
      cuentaId: json['cuenta_id'] as String,
      productoComprado: (json['producto_comprado'] as List<dynamic>)
          .map((e) => Carrito.fromJson(e as Map<String, dynamic>))
          .toList(),
      cuenta: json['cuenta'] == null
          ? null
          : Cuenta.fromJson(json['cuenta'] as Map<String, dynamic>),
      direccion: json['direccion'] == null
          ? null
          : Direccion.fromJson(json['direccion'] as Map<String, dynamic>),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      precioTotal: (json['precio_total'] as num?)?.toDouble(),
      costeEnvio: (json['coste_envio'] as num?)?.toDouble(),
      metodoPago: json['metodo_pago'] == null
          ? null
          : MetodoPago.fromJson(json['metodo_pago'] as Map<String, dynamic>),
      totalCuenta: (json['total_cuenta'] as num?)?.toDouble(),
      iva: (json['iva'] as num?)?.toDouble(),
      totalPagar: (json['total_pagar'] as num?)?.toDouble(),
      estadoTransaccion: json['estado_transaccion'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TransaccionToJson(Transaccion instance) =>
    <String, dynamic>{
      'transaccion_id': instance.transaccionId,
      'cuenta_id': instance.cuentaId,
      'cuenta': instance.cuenta?.toJson(),
      'direccion': instance.direccion?.toJson(),
      'producto_comprado':
          instance.productoComprado.map((e) => e.toJson()).toList(),
      'sub_total': instance.subTotal,
      'precio_total': instance.precioTotal,
      'coste_envio': instance.costeEnvio,
      'metodo_pago': instance.metodoPago?.toJson(),
      'total_cuenta': instance.totalCuenta,
      'iva': instance.iva,
      'total_pagar': instance.totalPagar,
      'estado_transaccion': instance.estadoTransaccion,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

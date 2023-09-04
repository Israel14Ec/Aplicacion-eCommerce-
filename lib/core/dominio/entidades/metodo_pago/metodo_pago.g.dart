// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metodo_pago.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetodoPago _$MetodoPagoFromJson(Map<String, dynamic> json) => MetodoPago(
      metodoPagoId: json['metodo_pago_id'] as String,
      numeroTarjeta: json['numero_tarjeta'] as String,
      nombreUsuarioTarjeta: json['cardholder_name'] as String,
      fechaExpiracion: json['fecha_expiracion'] as String,
      cvv: json['cvv'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MetodoPagoToJson(MetodoPago instance) =>
    <String, dynamic>{
      'metodo_pago_id': instance.metodoPagoId,
      'numero_tarjeta': instance.numeroTarjeta,
      'cardholder_name': instance.nombreUsuarioTarjeta,
      'fecha_expiracion': instance.fechaExpiracion,
      'cvv': instance.cvv,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

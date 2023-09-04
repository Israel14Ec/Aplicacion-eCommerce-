// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuenta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cuenta _$CuentaFromJson(Map<String, dynamic> json) => Cuenta(
      cuentaId: json['cuenta_id'] as String,
      nombre: json['nombre'] as String,
      email: json['email'] as String,
      numeroTelefonico: json['numero_telefonico'] as String,
      rol: json['rol'] as int,
      banEstado: json['ban_estado'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      metodoPagoPrimario: json['metodo_pago_primario'] == null
          ? null
          : MetodoPago.fromJson(
              json['metodo_pago_primario'] as Map<String, dynamic>),
      direccionPrimaria: json['direccion_primaria'] == null
          ? null
          : Direccion.fromJson(
              json['direccion_primaria'] as Map<String, dynamic>),
      urlFotoPerfil: json['url_foto_perfil'] as String,
    );

Map<String, dynamic> _$CuentaToJson(Cuenta instance) => <String, dynamic>{
      'cuenta_id': instance.cuentaId,
      'nombre': instance.nombre,
      'email': instance.email,
      'numero_telefonico': instance.numeroTelefonico,
      'rol': instance.rol,
      'ban_estado': instance.banEstado,
      'metodo_pago_primario': instance.metodoPagoPrimario,
      'direccion_primaria': instance.direccionPrimaria,
      'url_foto_perfil': instance.urlFotoPerfil,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

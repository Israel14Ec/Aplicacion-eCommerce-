// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Direccion _$DireccionFromJson(Map<String, dynamic> json) => Direccion(
      direccionId: json['direccion_id'] as String,
      nombre: json['nombre'] as String,
      direccion: json['direccion'] as String,
      ciudad: json['ciudad'] as String,
      codigoCasa: json['codigo_casa'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DireccionToJson(Direccion instance) => <String, dynamic>{
      'direccion_id': instance.direccionId,
      'nombre': instance.nombre,
      'direccion': instance.direccion,
      'ciudad': instance.ciudad,
      'codigo_casa': instance.codigoCasa,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

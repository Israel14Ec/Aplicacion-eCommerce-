// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listadeseos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListaDeseos _$ListaDeseosFromJson(Map<String, dynamic> json) => ListaDeseos(
      listadeseosId: json['lista_deseos_id'] as String,
      productoId: json['producto_id'] as String,
      producto: json['producto'] == null
          ? null
          : Producto.fromJson(json['producto'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ListaDeseosToJson(ListaDeseos instance) =>
    <String, dynamic>{
      'lista_deseos_id': instance.listadeseosId,
      'producto': instance.producto?.toJson(),
      'producto_id': instance.productoId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

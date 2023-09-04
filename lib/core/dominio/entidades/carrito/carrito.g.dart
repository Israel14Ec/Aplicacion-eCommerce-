// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrito.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carrito _$CarritoFromJson(Map<String, dynamic> json) => Carrito(
      carritoId: json['carrito_id'] as String,
      productoId: json['producto_id'] as String,
      producto: json['producto'] == null
          ? null
          : Producto.fromJson(json['producto'] as Map<String, dynamic>),
      cantidad: json['cantidad'] as int,
      total: (json['total'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CarritoToJson(Carrito instance) => <String, dynamic>{
      'carrito_id': instance.carritoId,
      'producto_id': instance.productoId,
      'producto': instance.producto?.toJson(),
      'cantidad': instance.cantidad,
      'total': instance.total,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

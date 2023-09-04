// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      reviewId: json['review_id'] as String,
      productoId: json['producto_id'] as String,
      producto: Producto.fromJson(json['product'] as Map<String, dynamic>),
      cuentaId: json['cuenta_id'] as String,
      estrellas: json['estrellas'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      nombreReviewer: json['nombre_reviewer'] as String,
      descripcion: json['descripcion'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'review_id': instance.reviewId,
      'producto_id': instance.productoId,
      'product': instance.producto.toJson(),
      'cuenta_id': instance.cuentaId,
      'nombre_reviewer': instance.nombreReviewer,
      'estrellas': instance.estrellas,
      'descripcion': instance.descripcion,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

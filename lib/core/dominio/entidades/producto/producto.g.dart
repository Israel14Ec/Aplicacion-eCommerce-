// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Producto _$ProductoFromJson(Map<String, dynamic> json) => Producto(
      productoId: json['producto_id'] as String,
      productoNombre: json['producto_nombre'] as String,
      productoPrecio: (json['producto_precio'] as num).toDouble(),
      productoDescripcion: json['producto_descripcion'] as String,
      productoImagen: (json['producto_imagen'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reviewsTotal: json['reviews_totales'] as int,
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductoToJson(Producto instance) => <String, dynamic>{
      'producto_id': instance.productoId,
      'producto_nombre': instance.productoNombre,
      'producto_precio': instance.productoPrecio,
      'producto_descripcion': instance.productoDescripcion,
      'producto_imagen': instance.productoImagen,
      'reviews_totales': instance.reviewsTotal,
      'rating': instance.rating,
      'stock': instance.stock,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

ProductoWeb _$ProductoWebFromJson(Map<String, dynamic> json) => ProductoWeb(
      productoId: json['producto_id'] as String,
      productoNombre: json['producto_nombre'] as String,
      productoPrecio: (json['producto_precio'] as num).toDouble(),
      productoDescripcion: json['producto_descripcion'] as String,
      productoImagen: (json['producto_imagen'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reviewsTotal: json['reviews_totales'] as int,
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductoWebToJson(ProductoWeb instance) =>
    <String, dynamic>{
      'producto_id': instance.productoId,
      'producto_nombre': instance.productoNombre,
      'producto_precio': instance.productoPrecio,
      'producto_descripcion': instance.productoDescripcion,
      'producto_imagen': instance.productoImagen,
      'reviews_totales': instance.reviewsTotal,
      'rating': instance.rating,
      'stock': instance.stock,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

ProductoMobile _$ProductoMobileFromJson(Map<String, dynamic> json) =>
    ProductoMobile(
      productoId: json['producto_id'] as String,
      productoNombre: json['producto_nombre'] as String,
      productoPrecio: (json['producto_precio'] as num).toDouble(),
      productoDescripcion: json['producto_descripcion'] as String,
      productoImagen: (json['producto_imagen'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reviewsTotal: json['reviews_totales'] as int,
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductoMobileToJson(ProductoMobile instance) =>
    <String, dynamic>{
      'producto_id': instance.productoId,
      'producto_nombre': instance.productoNombre,
      'producto_precio': instance.productoPrecio,
      'producto_descripcion': instance.productoDescripcion,
      'producto_imagen': instance.productoImagen,
      'reviews_totales': instance.reviewsTotal,
      'rating': instance.rating,
      'stock': instance.stock,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

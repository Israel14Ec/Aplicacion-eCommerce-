import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'producto.g.dart';

@JsonSerializable()
class Producto {
  @JsonKey(name: 'producto_id')
  String productoId;

  @JsonKey(name: 'producto_nombre')
  String productoNombre;

  @JsonKey(name: 'producto_precio')
  double productoPrecio;

  @JsonKey(name: 'producto_descripcion')
  String productoDescripcion;

  @JsonKey(name: 'producto_imagen')
  List<String> productoImagen;

  @JsonKey(name: 'reviews_totales')
  int reviewsTotal;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'stock')
  int stock;

  @JsonKey(name: 'is_deleted')
  bool isDeleted;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Producto({
    required this.productoId,
    required this.productoNombre,
    required this.productoPrecio,
    required this.productoDescripcion,
    required this.productoImagen,
    required this.reviewsTotal,
    required this.rating,
    required this.stock,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Producto.fromJson(Map<String, dynamic> json) =>
      _$ProductoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductoToJson(this);
}

@JsonSerializable()
class ProductoWeb extends Producto {
  // Atributos y métodos específicos para Flutter web, si los hay

  ProductoWeb({
    required String productoId,
    required String productoNombre,
    required double productoPrecio,
    required String productoDescripcion,
    required List<String> productoImagen,
    required int reviewsTotal,
    required double rating,
    required int stock,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          productoId: productoId,
          productoNombre: productoNombre,
          productoPrecio: productoPrecio,
          productoDescripcion: productoDescripcion,
          productoImagen: productoImagen,
          reviewsTotal: reviewsTotal,
          rating: rating,
          stock: stock,
          isDeleted: isDeleted,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ProductoWeb.fromJson(Map<String, dynamic> json) =>
      _$ProductoWebFromJson(json);

  Map<String, dynamic> toJson() => _$ProductoWebToJson(this);
}

@JsonSerializable()
class ProductoMobile extends Producto {
  // Atributos y métodos específicos para plataformas móviles, si los hay

  ProductoMobile({
    required String productoId,
    required String productoNombre,
    required double productoPrecio,
    required String productoDescripcion,
    required List<String> productoImagen,
    required int reviewsTotal,
    required double rating,
    required int stock,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          productoId: productoId,
          productoNombre: productoNombre,
          productoPrecio: productoPrecio,
          productoDescripcion: productoDescripcion,
          productoImagen: productoImagen,
          reviewsTotal: reviewsTotal,
          rating: rating,
          stock: stock,
          isDeleted: isDeleted,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ProductoMobile.fromJson(Map<String, dynamic> json) =>
      _$ProductoMobileFromJson(json);

  Map<String, dynamic> toJson() => _$ProductoMobileToJson(this);
}

Producto fromJson(Map<String, dynamic> json) {
  if (kIsWeb) {
    return ProductoWeb.fromJson(json);
  } else {
    return ProductoMobile.fromJson(json);
  }
}

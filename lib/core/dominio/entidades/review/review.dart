import 'package:json_annotation/json_annotation.dart';

import '../producto/producto.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  @JsonKey(name: 'review_id')
  String reviewId;

  @JsonKey(name: 'producto_id')
  String productoId;

  @JsonKey(name: 'product')
  Producto producto;

  @JsonKey(name: 'cuenta_id')
  String cuentaId;

  @JsonKey(name: 'nombre_reviewer')
  String nombreReviewer;

  @JsonKey(name: 'estrellas')
  int estrellas;

  @JsonKey(name: 'descripcion')
  String? descripcion;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Review({
    required this.reviewId,
    required this.productoId,
    required this.producto,
    required this.cuentaId,
    required this.estrellas,
    required this.createdAt,
    required this.updatedAt,
    required this.nombreReviewer,
    this.descripcion,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

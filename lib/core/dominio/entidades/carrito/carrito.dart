import 'package:json_annotation/json_annotation.dart';

import '../producto/producto.dart';

part 'carrito.g.dart';

@JsonSerializable(explicitToJson: true)
class Carrito {
  @JsonKey(name: 'carrito_id')
  String carritoId;

  @JsonKey(name: 'producto_id')
  String productoId;

  @JsonKey(name: 'producto')
  Producto? producto;

  @JsonKey(name: 'cantidad')
  int cantidad;

  @JsonKey(name: 'total')
  double total;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Carrito({
    required this.carritoId,
    required this.productoId,
    this.producto,
    required this.cantidad,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) => _$CarritoFromJson(json);

  Map<String, dynamic> toJson() => _$CarritoToJson(this);
}

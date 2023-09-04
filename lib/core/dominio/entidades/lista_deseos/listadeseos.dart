import 'package:json_annotation/json_annotation.dart';

import '../producto/producto.dart';

part 'listadeseos.g.dart';

@JsonSerializable(explicitToJson: true)
class ListaDeseos {
  @JsonKey(name: 'lista_deseos_id')
  String listadeseosId;

  @JsonKey(name: 'producto')
  Producto? producto;

  @JsonKey(name: 'producto_id')
  String productoId;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  ListaDeseos({
    required this.listadeseosId,
    required this.productoId,
    this.producto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ListaDeseos.fromJson(Map<String, dynamic> json) => _$ListaDeseosFromJson(json);

  Map<String, dynamic> toJson() => _$ListaDeseosToJson(this);
}

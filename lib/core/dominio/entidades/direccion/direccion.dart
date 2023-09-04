import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'direccion.g.dart';

@JsonSerializable()
class Direccion extends Equatable {
  @JsonKey(name: 'direccion_id')
  final String direccionId;

  @JsonKey(name: 'nombre')
  final String nombre;

  @JsonKey(name: 'direccion')
  final String direccion;

  @JsonKey(name: 'ciudad')
  final String ciudad;

  @JsonKey(name: 'codigo_casa')
  final String codigoCasa;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const Direccion({
    required this.direccionId,
    required this.nombre,
    required this.direccion,
    required this.ciudad,
    required this.codigoCasa,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) => _$DireccionFromJson(json);

  Map<String, dynamic> toJson() => _$DireccionToJson(this);

  @override
  List<Object?> get props => [direccionId];
}

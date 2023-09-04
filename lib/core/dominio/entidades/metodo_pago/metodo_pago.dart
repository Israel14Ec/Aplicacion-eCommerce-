import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metodo_pago.g.dart';

@JsonSerializable()
class MetodoPago extends Equatable {
  @JsonKey(name: 'metodo_pago_id')
  final String metodoPagoId;

  @JsonKey(name: 'numero_tarjeta')
  final String numeroTarjeta;

  @JsonKey(name: 'cardholder_name')
  final String nombreUsuarioTarjeta;

  @JsonKey(name: 'fecha_expiracion')
  final String fechaExpiracion;

  @JsonKey(name: 'cvv')
  final String cvv;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const MetodoPago({
    required this.metodoPagoId,
    required this.numeroTarjeta,
    required this.nombreUsuarioTarjeta,
    required this.fechaExpiracion,
    required this.cvv,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => _$MetodoPagoFromJson(json);

  Map<String, dynamic> toJson() => _$MetodoPagoToJson(this);

  @override
  List<Object?> get props => [metodoPagoId];
}

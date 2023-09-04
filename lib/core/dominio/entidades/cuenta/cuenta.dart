import 'package:json_annotation/json_annotation.dart';

import '../direccion/direccion.dart';
import '../metodo_pago/metodo_pago.dart';

part 'cuenta.g.dart';

@JsonSerializable()
class Cuenta {
  @JsonKey(name: 'cuenta_id')
  String cuentaId;

  @JsonKey(name: 'nombre')
  String nombre;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'numero_telefonico')
  String numeroTelefonico;

  @JsonKey(name: 'rol')
  int rol;

  @JsonKey(name: 'ban_estado')
  bool banEstado;

  @JsonKey(name: 'metodo_pago_primario')
  MetodoPago? metodoPagoPrimario;

  @JsonKey(name: 'direccion_primaria')
  Direccion? direccionPrimaria;

  @JsonKey(name: 'url_foto_perfil')
  String urlFotoPerfil;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Cuenta({
    required this.cuentaId,
    required this.nombre,
    required this.email,
    required this.numeroTelefonico,
    required this.rol,
    required this.banEstado,
    required this.createdAt,
    required this.updatedAt,
    this.metodoPagoPrimario,
    this.direccionPrimaria,
    required this.urlFotoPerfil,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) => _$CuentaFromJson(json);

  Map<String, dynamic> toJson() => _$CuentaToJson(this);
}

import 'package:edreams/configuracion/rol_config.dart';

enum Flavor {
  usuario(1),
  admin(2);

  final int rolValor;
  const Flavor(this.rolValor);

  @override
  String toString() => "Has ingresado como ${name.toUpperCase()}";
}

class FlavorValues {
  final RolConfig rolConfig;

  FlavorValues({
    required this.rolConfig,
  });
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues flavorValores;
  static late FlavorConfig _instancia;

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues flavorValores,
  }) {
    _instancia = FlavorConfig._internal(flavor, flavorValores);

    return _instancia;
  }

  FlavorConfig._internal(this.flavor, this.flavorValores);
  static FlavorConfig get instancia {
    return _instancia;
  }

  static bool isUsuario() => _instancia.flavor == Flavor.usuario;
  static bool isAdmin() => _instancia.flavor == Flavor.admin;
}

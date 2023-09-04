import 'package:edreams/verificaciones/extension.dart';

class OrdenarPorValor {
  final String ordenarPor;
  final bool descendente;

  OrdenarPorValor({
    required this.ordenarPor,
    required this.descendente,
  });
}

enum OrdenarPorEnum {
  nuevo(0),
  viejo(1),
  barato(2),
  caro(3),
  menosEstrellas(4),
  masEstrellas(5);

  final num valor;
  const OrdenarPorEnum(this.valor);

  @override
  String toString() => name.mayusculaPrimeraLetra();
}

OrdenarPorValor getEnumValor(OrdenarPorEnum data) {
  switch (data) {
    case OrdenarPorEnum.nuevo:
      return OrdenarPorValor(ordenarPor: 'creado_el', descendente: true);
    case OrdenarPorEnum.viejo:
      return OrdenarPorValor(ordenarPor: 'creado_el', descendente: false);
    case OrdenarPorEnum.barato:
      return OrdenarPorValor(ordenarPor: 'precio_producto', descendente: false);
    case OrdenarPorEnum.caro:
      return OrdenarPorValor(ordenarPor: 'precio_producto', descendente: true);
    default:
      return OrdenarPorValor(ordenarPor: 'creado_el', descendente: true);
  }
}

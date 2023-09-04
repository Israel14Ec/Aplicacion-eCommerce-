import 'dart:math';

import 'package:edreams/app/constantes/codigo_pais.dart';
import 'package:intl/intl.dart';

extension ExtensionString on String {
  String generateUID() {
    const int longitud = 20;
    const String alfabeto = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    const int maxRandom = alfabeto.length;
    final Random randomGen = Random();

    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < longitud; i++) {
      buffer.write(alfabeto[randomGen.nextInt(maxRandom)]);
    }

    return buffer.toString();
  }

  String mayusculaPrimeraLetra() {
    final antesLetraMayuscula = RegExp(r"(?=(?!^)[A-Z])");
    List<String> splitPascalCase(String input) => input.split(antesLetraMayuscula);

    List<String> data = splitPascalCase(this);

    String texto = '';

    if (data.length > 1) {
      for (var element in data) {
        texto += '${element[0].toUpperCase()}${element.substring(1).toLowerCase()}';
        texto += ' ';
      }
    } else {
      texto += '${data.first[0].toUpperCase()}${data.first.substring(1).toLowerCase()}';
    }

    return texto;
  }

  String separarCodigoPais() {
    String numeroTelefonico = '';
    String codigoPais = '';

    for (var element in CodigoPais.dataCodigoPais) {
      String codigo = element[2];
      String codigoTelp = substring(0, codigo.length);
      if (codigoTelp.contains(codigo)) {
        numeroTelefonico = substring(codigo.length);
        codigoPais = codigo;
        break;
      }
    }

    String result = '+$codigoPais $numeroTelefonico';

    return result;
  }
}

extension DoubleExtension on double {
  String toCurrency() {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(this);
  }
}

extension IntExtension on int {
  String toNumericFormat() {
    return NumberFormat("#,###").format(this);
  }
}

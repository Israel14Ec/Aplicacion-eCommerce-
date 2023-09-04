import 'package:flutter/services.dart';

class FormatoExpiracionTarjeta extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final cadenaNuevoValor = newValue.text;
    String valorRegreso = '';

    for (int i = 0; i < cadenaNuevoValor.length; i++) {
      if (cadenaNuevoValor[i] != '/') valorRegreso += cadenaNuevoValor[i];
      var indexNoCero = i + 1;
      final contains = valorRegreso.contains(RegExp(r'\/'));
      if (indexNoCero % 2 == 0 && indexNoCero != cadenaNuevoValor.length && !(contains)) {
        valorRegreso += '/';
      }
    }
    return newValue.copyWith(
      text: valorRegreso,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valorRegreso.length),
      ),
    );
  }
}

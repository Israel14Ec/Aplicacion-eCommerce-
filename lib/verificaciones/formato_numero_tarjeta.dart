import 'package:flutter/services.dart';

class FormatoNumeroTarjeta extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var textoEntrada = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < textoEntrada.length; i++) {
      bufferString.write(textoEntrada[i]);
      var valorIndexNoCero = i + 1;
      if (valorIndexNoCero % 4 == 0 && valorIndexNoCero != textoEntrada.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

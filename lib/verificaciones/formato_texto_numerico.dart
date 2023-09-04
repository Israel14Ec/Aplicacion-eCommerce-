import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormatoTextoNumerico extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int seleccionarIndexDerecha = newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final numero = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final nuevaCadena = f.format(numero);
      return TextEditingValue(
        text: nuevaCadena,
        selection: TextSelection.collapsed(offset: nuevaCadena.length - seleccionarIndexDerecha),
      );
    } else {
      return newValue;
    }
  }
}

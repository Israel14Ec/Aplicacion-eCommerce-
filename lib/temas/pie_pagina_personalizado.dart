import 'package:flutter/material.dart';

class PiePaginaPersonalizado {
  static const BottomSheetThemeData TipoPiePagina = BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
  );
}

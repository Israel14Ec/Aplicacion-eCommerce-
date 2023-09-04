import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ComprimirImagen {
  static Future<Uint8List> empezarCompresion(Uint8List lista) async {
    var resultado = await FlutterImageCompress.compressWithList(lista);
    return resultado;
  }
}

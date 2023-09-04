import 'dart:async';
import 'dart:html' as html;

Future<List<html.File>> getImagenes(void Function(List<html.File>) callback) async {
  final html.InputElement? input = html.FileUploadInputElement() as html.InputElement?;
  input?.accept = 'image/*';
  input?.multiple = true; // Permite la selección de múltiples archivos
  input?.click();

  final completer = Completer<List<html.File>>();

  input?.onChange.listen((event) {
    final files = input.files;
    if (files != null && files.isNotEmpty) {
      final List<html.File> fileList = files.toList();
      callback(fileList);
      completer.complete(fileList);
    } else {
      callback([]);
      completer.complete([]);
    }
  });

  return completer.future;
}
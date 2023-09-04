import 'dart:async';
import 'dart:html' as html;

Future<List<String>> getImagePaths(List<html.File> selectedImages) async {
  List<String> imagePaths = [];

  for (var archivo in selectedImages) {
    final reader = html.FileReader();

    reader.readAsDataUrl(archivo);

    await reader.onLoad.first;

    final result = reader.result;
    if (result != null) {
      imagePaths.add(result as String);
    }
  }

  return imagePaths;
}

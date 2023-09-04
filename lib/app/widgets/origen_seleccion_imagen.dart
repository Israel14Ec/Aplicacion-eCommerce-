import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker_web/image_picker_web.dart'; // Importamos image_picker_web

class OrigenSeleccionImagen extends StatefulWidget {
  const OrigenSeleccionImagen({Key? key}) : super(key: key);

  @override
  State<OrigenSeleccionImagen> createState() => _OrigenSeleccionImagenState();
}

class _OrigenSeleccionImagenState extends State<OrigenSeleccionImagen> {
  Future<void> _getImageFromSource(ImageSource source) async {
    dynamic image;

    if (kIsWeb) {
      // Para la web, utilizamos image_picker_web
      final pickedFile = await ImagePickerWeb.getImageAsWidget();
      if (pickedFile != null) {
        image = pickedFile;
      }
    } else {
      // Para Android e iOS, utilizamos image_picker
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = pickedFile.path;
      }
    }

    if (image != null) {
      Navigator.of(context).pop(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Elegir imagen de"),
      content: const Text("Las imagenes pueden ser tomadas de la camara o de la galeria"),
      actions: [
        TextButton(
          onPressed: () {
            _getImageFromSource(ImageSource.camera);
          },
          child: const Text(
            "Camara",
            textAlign: TextAlign.start,
          ),
        ),
        TextButton(
          onPressed: () {
            _getImageFromSource(ImageSource.gallery);
          },
          child: const Text("Galeria"),
        ),
      ],
    );
  }
}

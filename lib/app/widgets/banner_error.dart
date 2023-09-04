import 'package:edreams/temas/color_personalizado.dart';
import 'package:flutter/material.dart';

bannerError({required BuildContext context, required String msg}) {
  return MaterialBanner(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    contentTextStyle: const TextStyle(color: Colors.white),
    content: Text(msg),
    backgroundColor: ColorPersonalizado.error,
    actions: [
      InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: const Text(
          "DESCARTAR",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ],
  );
}

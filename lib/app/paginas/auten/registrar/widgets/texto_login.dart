import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextoLogin extends StatelessWidget {
  const TextoLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '¿Ya tienes cuenta? Ingresa aqui',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: ' Ingresar',
            style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: ValorColores.colorPrimario(context),
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pop();
              },
          ),
        ],
      ),
    );
  }
}

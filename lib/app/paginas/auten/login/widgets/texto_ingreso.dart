import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/rutas.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextoIngreso extends StatelessWidget {
  const TextoIngreso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '¿No tienes cuenta? ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: 'Ingresar',
            style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: ValorColores.colorPrimario(context),
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                RutaNavegacion.toRegistro(context: context);
              },
          ),
        ],
      ),
    );
  }
}

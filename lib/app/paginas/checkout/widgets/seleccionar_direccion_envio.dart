import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/temas/color_personalizado.dart';
import 'package:flutter/material.dart';


class SeleccionarDireccionEnvio extends StatelessWidget {
  final Direccion? direccionEnvio;
  final Function() seleccionarDireccion;
  final Function() removerDireccion;
  const SeleccionarDireccionEnvio({
    Key? key,
    this.direccionEnvio,
    required this.seleccionarDireccion,
    required this.removerDireccion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Direccion de envio',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (direccionEnvio != null)
              TextButton(
                onPressed: () {
                  seleccionarDireccion();
                },
                child: const Text('Otras direcciones'),
              ),
          ],
        ),
        if (direccionEnvio == null)
          TextButton.icon(
            onPressed: () {
              seleccionarDireccion();
            },
            icon: Icon(
              Icons.add_rounded,
              color: ValorColores.colorPrimario(context),
            ),
            label: const Text('Añadir direccion'),
          ),
        if (direccionEnvio != null)
          ListTile(
            dense: true,
            title: Text(direccionEnvio!.nombre),
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4),
            subtitle: Text(
              '${direccionEnvio!.direccion} ${direccionEnvio!.ciudad} ${direccionEnvio!.codigoCasa}',
            ),
            trailing: IconButton(
              onPressed: () {
                removerDireccion();
              },
              icon: const Icon(
                Icons.clear_rounded,
                color: ColorPersonalizado.error,
              ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

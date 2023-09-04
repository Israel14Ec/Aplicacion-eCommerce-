import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/core/dominio/entidades/transaccion/transaccion.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';

class EstadoTransaccionCheckbox extends StatefulWidget {
  final EstadoTransaccion seleccionarEstado;
  const EstadoTransaccionCheckbox({Key? key, required this.seleccionarEstado}) : super(key: key);

  @override
  State<EstadoTransaccionCheckbox> createState() => _EstadoTransaccionCheckboxState();
}

class _EstadoTransaccionCheckboxState extends State<EstadoTransaccionCheckbox> {
  EstadoTransaccion? seleccionarEstado;

  List<EstadoTransaccion> estados = [];

  @override
  void initState() {
    seleccionarEstado = widget.seleccionarEstado;
    for (var estado in EstadoTransaccion.values) {
      if (estado != EstadoTransaccion.recibido && estado != EstadoTransaccion.calificado) {
        estados.add(estado);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Estado Transaccion',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          ...estados.map((estado) {
            return CheckboxListTile(
              title: Text(estado.name.mayusculaPrimeraLetra()),
              value: seleccionarEstado == estado,
              activeColor: ValorColores.colorPrimario(context),
              onChanged: (valor) {
                if (valor!) {
                  setState(() {
                    seleccionarEstado = estado;
                  });
                } else {
                  setState(() {
                    seleccionarEstado = null;
                  });
                }
              },
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: seleccionarEstado == null
                ? null
                : () {
                    Navigator.of(context).pop(seleccionarEstado);
                  },
            child: const Text('Cambiar Estado'),
          ),
        ],
      ),
    );
  }
}

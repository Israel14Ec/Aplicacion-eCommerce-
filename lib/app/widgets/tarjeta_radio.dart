import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:flutter/material.dart';

class TarjetaRadio<T> extends StatelessWidget {
  final T valor;
  final T? seleccionarValor;
  final void Function(T?) onChanged;
  final String titulo;
  final String subtitulo;
  final Function() onDelete;
  final Function() onEdit;
  const TarjetaRadio({
    Key? key,
    required this.valor,
    required this.seleccionarValor,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
    required this.titulo,
    required this.subtitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = valor == seleccionarValor;

    return InkWell(
      onTap: () {
        isSelected ? onChanged(null) : onChanged(valor);
      },
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? ValorColores.colorPrimario(context) : Theme.of(context).colorScheme.outline,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Radio<T>(
                    value: valor,
                    groupValue: seleccionarValor,
                    onChanged: onChanged,
                    toggleable: true,
                    activeColor: ValorColores.colorPrimario(context),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitulo,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: onDelete,
                    child: const Text('Eliminar'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: onEdit,
                    child: const Text('Editar'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




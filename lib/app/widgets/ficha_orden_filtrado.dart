import 'package:edreams/app/constantes/ordenar_por_valor.dart';
import 'package:flutter/material.dart';

class FichaOrdenFiltrado extends StatelessWidget {
  final List<OrdenarPorEnum> dataEnum;
  final Function(OrdenarPorEnum valor) onSelected;
  final OrdenarPorEnum seleccionadoEnum;
  const FichaOrdenFiltrado({
    Key? key,
    required this.dataEnum,
    required this.onSelected,
    required this.seleccionadoEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ordenar',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            children: dataEnum.map((e) {
              return FilterChip(
                label: Text(e.toString()),
                selected: seleccionadoEnum == e,
                onSelected: (value) {
                  onSelected(e);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

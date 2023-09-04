import 'package:flutter/material.dart';

class ContadorYOpciones extends StatelessWidget {
  final int contador;
  final String nombreObjeto;
  final bool isOrdenada;
  final Function() onTap;
  const ContadorYOpciones({
    Key? key,
    required this.contador,
    required this.nombreObjeto,
    required this.isOrdenada,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Hay',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: ' ' '$contador $nombreObjeto',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        isOrdenada
            ? OutlinedButton.icon(
                onPressed: () {
                  onTap();
                },
                icon: const Icon(Icons.sort_rounded),
                label: const Text('Ordenar'),
              )
            : OutlinedButton.icon(
                onPressed: () {
                  onTap();
                },
                icon: const Icon(Icons.filter_list_rounded),
                label: const Text('Filtrar'),
              ),
      ],
    );
  }
}

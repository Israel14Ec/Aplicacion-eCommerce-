import 'package:edreams/app/constantes/valor_colores.dart';

import 'package:flutter/material.dart';

class BotonAccionUsuario extends StatelessWidget {
  final Function() onTapFavorite;
  final void Function()? onTapAddToCart;
  final bool isListaDeseos;
  const BotonAccionUsuario({
    Key? key,
    required this.onTapFavorite,
    required this.onTapAddToCart,
    this.isListaDeseos = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              onTapFavorite();
            },
            icon: isListaDeseos ? const Icon(Icons.favorite_rounded) : const Icon(Icons.favorite_border_rounded),
            color: ValorColores.colorPrimario(context),
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              disabledBackgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              hoverColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
              focusColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
              highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: ElevatedButton(
              onPressed: onTapAddToCart,
              child: onTapAddToCart == null ? const Text('Fuera de Stock') : const Text('Añadir al carrito'),
            ),
          ),
        ],
      ),
    );
  }
}

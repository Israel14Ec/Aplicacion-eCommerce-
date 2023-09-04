import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/core/dominio/entidades/cuenta/cuenta.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContenedorCliente extends StatelessWidget {
  final Cuenta cliente;
  const ContenedorCliente({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.transparent,
            backgroundImage: cliente.urlFotoPerfil.isNotEmpty ? NetworkImage(cliente.urlFotoPerfil) : null,
            child: cliente.urlFotoPerfil.isEmpty
                ? const Icon(
                    Icons.person,
                    size: 32,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  cliente.nombre,
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  cliente.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  cliente.numeroTelefonico.separarCodigoPais(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    cliente.banEstado
                        ? OutlinedButton(
                            onPressed: () {
                              context.read<ProveedorCuenta>().ban(cuentaId: cliente.cuentaId, ban: false);
                            },
                            child: const Text('Desbanear Usuario'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              context.read<ProveedorCuenta>().ban(cuentaId: cliente.cuentaId, ban: true);
                            },
                            child: const Text('Banear Usuario'),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

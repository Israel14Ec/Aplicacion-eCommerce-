import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../widgets/banner_error.dart';

class DialogoEditPerfil extends StatefulWidget {
  final String titulo;
  final String textoSugerido;
  final String labelTexto;
  final String valorInicial;
  final String nombreCampo;
  final String? Function(String?) validacion;
  final bool isTelefono;
  const DialogoEditPerfil({
    Key? key,
    required this.titulo,
    required this.textoSugerido,
    required this.labelTexto,
    required this.valorInicial,
    required this.nombreCampo,
    required this.validacion,
    this.isTelefono = false,
  }) : super(key: key);

  @override
  State<DialogoEditPerfil> createState() => _DialogoEditPerfilState();
}

class _DialogoEditPerfilState extends State<DialogoEditPerfil> {
  // Form Key (PARA VALIDACION)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador TextEditing & FocusNode
  final TextEditingController _txt = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  void initState() {
    _txt.text = widget.valorInicial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.titulo,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            // Ingreso de email
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _txt,
                focusNode: _fn,
                validator: widget.validacion,
                keyboardType: widget.isTelefono ? TextInputType.phone : TextInputType.text,
                inputFormatters: widget.isTelefono
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                      ]
                    : null,
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: widget.textoSugerido,
                  labelText: widget.labelTexto,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Boton de actualizar
            Consumer<ProveedorCuenta>(
              builder: (context, valor, child) {
                if (valor.isCargando) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    // Si el valor no esta cargado
                    if (_txt.text == widget.valorInicial) {
                      Navigator.of(context).pop();
                      return;
                    }

                    // Verifica si el formato es valido
                    if (_formKey.currentState!.validate() && !valor.isCargando) {
                      try {
                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                        await valor.update(
                          data: {widget.nombreCampo: _txt.text},
                        ).whenComplete(() {
                          _formKey.currentState!.reset();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Actualizacion Exitosa'),
                            ),
                          );
                          Navigator.of(context).pop();
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          bannerError(context: context, msg: e.toString()),
                        );
                      }
                    }
                  },
                  child: const Text('Actualizar'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

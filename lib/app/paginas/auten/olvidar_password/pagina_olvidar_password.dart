import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/app/proveedores/proveedor_auten.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../widgets/banner_error.dart';

class PaginaOlvidarPassword extends StatefulWidget {
  const PaginaOlvidarPassword({Key? key}) : super(key: key);

  @override
  State<PaginaOlvidarPassword> createState() => _PaginaOlvidarPasswordState();
}

class _PaginaOlvidarPasswordState extends State<PaginaOlvidarPassword> {
  // Form Key (Para validaciones)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador TextEditing & FocusNode
  final TextEditingController _txtEmailAddress = TextEditingController();
  final FocusNode _fnEmailAddress = FocusNode();

  // Validacion
  TipoValidaciones validation = TipoValidaciones.instancia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo svg, asi que se cambia con el color primario del programa
              SvgPicture.asset(
                'assets/images/logo.svg',
                semanticsLabel: 'Logo',
                color: ValorColores.colorPrimario(context),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                'Olvidar contraseña',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Por favor ingresa tu correo electronico para enviarte un correo electronico y reestablecer tu contraseña',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 32),

              // Ingreso direccion correo electronico
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _txtEmailAddress,
                  focusNode: _fnEmailAddress,
                  validator: validation.validacionEmail,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    hintText: 'Ingresa tu direccion de correo electronico',
                    labelText: 'Direccion de correo electronico',
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Boton de logeo
              Consumer<ProveedorAuten>(
                builder: (context, value, child) {
                  if (value.isCargando) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      // Verificar si el formato es valido
                      if (_formKey.currentState!.validate() && !value.isCargando) {
                        try {
                          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                          await value
                              .resetPassword(
                            email: _txtEmailAddress.text,
                          )
                              .whenComplete(() {
                            _formKey.currentState!.reset();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Correo electronico enviado'),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            bannerError(context: context, msg: e.toString()),
                          );
                        }
                      }
                    },
                    child: const Text('Resetear Contraseña'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/app/proveedores/proveedor_auten.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/rutas.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'widgets/texto_ingreso.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  // Flavor
  FlavorConfig flavor = FlavorConfig.instancia;

  // Form Key (Para validacion)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador texto edicion & nodo focus
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final FocusNode _fnEmail = FocusNode();
  final FocusNode _fnPassword = FocusNode();

  // Oscurecer Text
  bool _oscurecerTexto = true;

  // Validacion
  TipoValidaciones validation = TipoValidaciones.instancia;

  @override
  void dispose() {
    _txtEmail.dispose();
    _txtPassword.dispose();
    _fnEmail.dispose();
    _fnPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo esta en svg, asi que se cambia con el color primario del programa
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  semanticsLabel: 'Logo',
                  color: ValorColores.colorPrimario(context),
                ),
                const SizedBox(height: 16),

                // Titulo
                Text(
                  'Ingresa con tu cuenta',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Subtitle
                Text(
                  'Bienvenido de vuelta, ingresa tus credenciales',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                // Form
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Ingreso de email
                        TextFormField(
                          controller: _txtEmail,
                          focusNode: _fnEmail,
                          validator: validation.validacionEmail,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnPassword),
                          decoration: const InputDecoration(
                            hintText: 'Ingresa tu direccion de correo electronico',
                            labelText: 'Direccion de correo electronico',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Ingreso de password
                        TextFormField(
                          controller: _txtPassword,
                          focusNode: _fnPassword,
                          obscureText: _oscurecerTexto,
                          validator: validation.validacionPassword,
                          onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_oscurecerTexto ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                              onPressed: () {
                                setState(() {
                                  _oscurecerTexto = !_oscurecerTexto;
                                });
                              },
                            ),
                            hintText: 'Ingresa tu contraseña',
                            labelText: 'Contraseña',
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            RutaNavegacion.toOlvidarPassword(context: context);
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Boton de logeo
                        Consumer<ProveedorAuten>(
                          builder: (context, valor, child) {
                            if (valor.isCargando) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                // Verificar si el formato valido
                                if (_formKey.currentState!.validate() && !valor.isCargando) {
                                  try {
                                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                                    await valor
                                        .login(
                                      email: _txtEmail.text,
                                      password: _txtPassword.text,
                                    )
                                        .then((e) {
                                      if (!valor.isRolValido) {
                                        _formKey.currentState!.reset();

                                        ScaffoldMessenger.of(context).showMaterialBanner(
                                          bannerError(
                                              context: context, msg: 'Tu cuenta no tiene los permisos suficientes'),
                                        );
                                      }
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                                    ScaffoldMessenger.of(context).showMaterialBanner(
                                      bannerError(context: context, msg: e.toString()),
                                    );
                                  }
                                }
                              },
                              child: const Text('Login'),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Sign Up Text
                        const TextoIngreso(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

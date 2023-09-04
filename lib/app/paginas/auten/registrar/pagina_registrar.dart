import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/app/proveedores/proveedor_auten.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/configuracion/flavor_config.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/texto_login.dart';

class PaginaRegistro extends StatefulWidget {
  const PaginaRegistro({Key? key}) : super(key: key);

  @override
  State<PaginaRegistro> createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  // Flavor
  FlavorConfig flavor = FlavorConfig.instancia;

  // Form Key (Para validaciones)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador TextEditing
  final TextEditingController _txtNombre = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtNumeroTelefonico = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final TextEditingController _txtConfirmarPassword = TextEditingController();

  // Focus Node
  final FocusNode _fnNombre = FocusNode();
  final FocusNode _fnEmail = FocusNode();
  final FocusNode _fnNumeroTelefonico = FocusNode();
  final FocusNode _fnPassword = FocusNode();
  final FocusNode _fnConfirmarPassword = FocusNode();

  // Oscurecer Text
  bool _oscurecerTexto = true;
  bool _oscurecerConfirmar = true;

  // Aceptar terminos y servicios
  bool _aceptarTerminosServicios = false;

  // Validacion
  TipoValidaciones validation = TipoValidaciones.instancia;

  @override
  void dispose() {
    _txtNombre.dispose();
    _txtEmail.dispose();
    _txtNumeroTelefonico.dispose();
    _txtPassword.dispose();
    _txtConfirmarPassword.dispose();

    _fnNombre.dispose();
    _fnEmail.dispose();
    _fnNumeroTelefonico.dispose();
    _fnPassword.dispose();
    _fnConfirmarPassword.dispose();
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
                  'Crear una Cuenta',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Subtitutlo
                Text(
                  'Ingresa con tu cuenta para empezar a navegar.',
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
                        // Ingresar Nombre
                        TextFormField(
                          controller: _txtNombre,
                          focusNode: _fnNombre,
                          validator: validation.validacionVacio,
                          onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnEmail),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: 'Ingresa tu nombre completo',
                            labelText: 'Nombre Completo',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Input Email Address
                        TextFormField(
                          controller: _txtEmail,
                          focusNode: _fnEmail,
                          validator: validation.validacionEmail,
                          onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnNumeroTelefonico),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Ingresar tu direccion de correo electronico',
                            labelText: 'Direccion de correo electronico',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Insertar numero telefonico
                        TextFormField(
                          controller: _txtNumeroTelefonico,
                          focusNode: _fnNumeroTelefonico,
                          validator: validation.validacionNumeroTelefonico,
                          onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnPassword),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 14,
                          decoration: const InputDecoration(
                            hintText: 'Codigo Paid + Numero Telefonico (ex: 0323943978)',
                            labelText: 'Numero Telefonico',
                            counterText: '',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Insertar Password
                        TextFormField(
                          controller: _txtPassword,
                          focusNode: _fnPassword,
                          obscureText: _oscurecerTexto,
                          validator: validation.validacionPassword,
                          onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnConfirmarPassword),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_oscurecerTexto ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                              onPressed: () {
                                setState(() {
                                  _oscurecerTexto = !_oscurecerTexto;
                                });
                              },
                            ),
                            hintText: 'Ingresar contraseña',
                            labelText: 'Contraseña',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Ingresar confirmar contraseña
                        TextFormField(
                          controller: _txtConfirmarPassword,
                          focusNode: _fnConfirmarPassword,
                          obscureText: _oscurecerConfirmar,
                          validator: (value) {
                            return validation.validacionConfirmarPassword(value, _txtPassword.text);
                          },
                          onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_oscurecerConfirmar ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                              onPressed: () {
                                setState(() {
                                  _oscurecerConfirmar = !_oscurecerConfirmar;
                                });
                              },
                            ),
                            hintText: 'Ingresa de nuevo tu contraseña',
                            labelText: 'Confirmar Contraseña',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              activeColor: ValorColores.colorPrimario(context),
                              value: _aceptarTerminosServicios,
                              onChanged: (valores) {
                                setState(() {
                                  _aceptarTerminosServicios = valores!;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'He leido y acepto los', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(
                                      text: ' Terminos y Servicios',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: ValorColores.colorPrimario(context),
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          // TODO: Change your terms of service
                                          Uri url = Uri.parse('https://generator.lorem-ipsum.info/terms-and-conditions');
                                          if (!await launchUrl(url)) {
                                            throw 'No se puede acceder a $url';
                                          }
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Boton de ingresar
                        Consumer<ProveedorAuten>(
                          builder: (context, valor, child) {
                            if (valor.isCargando) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ElevatedButton(
                              onPressed: _aceptarTerminosServicios
                                  ? () async {
                                      FocusScope.of(context).unfocus();
                                      // Validar si el formato es valido
                                      if (_formKey.currentState!.validate() && !valor.isCargando) {
                                        try {
                                          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                                          await valor
                                              .registro(
                                            emailAddress: _txtEmail.text,
                                            password: _txtPassword.text,
                                            nombre: _txtNombre.text,
                                            numeroTelefonico: _txtNumeroTelefonico.text,
                                          )
                                              .then((value) {
                                            Navigator.of(context).pop();
                                          });
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showMaterialBanner(
                                            bannerError(context: context, msg: e.toString()),
                                          );
                                        }
                                      }
                                    }
                                  : null,
                              child: const Text('Empezar'),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Login Text
                        const TextoLogin(),
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

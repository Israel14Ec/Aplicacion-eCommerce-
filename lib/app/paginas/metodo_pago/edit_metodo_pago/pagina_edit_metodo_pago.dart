import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/proveedores/proveedor_metodo_pago.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/core/dominio/entidades/metodo_pago/metodo_pago.dart';
import 'package:edreams/verificaciones/formato_expiracion_tarjeta.dart';
import 'package:edreams/verificaciones/formato_numero_tarjeta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PaginaEditMetodosPago extends StatefulWidget {
  const PaginaEditMetodosPago({Key? key}) : super(key: key);

  @override
  State<PaginaEditMetodosPago> createState() => _PaginaEditMetodosPagoState();
}

class _PaginaEditMetodosPagoState extends State<PaginaEditMetodosPago> {
  late MetodoPago metodoPago;

  // Form Key (Para validacion)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _txtNumeroTarjeta = TextEditingController();
  final TextEditingController _txtNombreUsuarioTarjeta = TextEditingController();
  final TextEditingController _txtFechaExpiracion = TextEditingController();
  final TextEditingController _txtCVV = TextEditingController();

  // FocusNode
  final FocusNode _fnCNumeroTarjeta = FocusNode();
  final FocusNode _fnNombreUsuarioTarjeta = FocusNode();
  final FocusNode _fnFechaExpiracion = FocusNode();
  final FocusNode _fnCVV = FocusNode();

  // Validacion
  TipoValidaciones validacion = TipoValidaciones.instancia;

  bool _isCargando = false;

  @override
  void initState() {
    Future.microtask(() {
      metodoPago = ModalRoute.of(context)!.settings.arguments as MetodoPago;

      _txtNumeroTarjeta.text = metodoPago.numeroTarjeta;
      _txtNombreUsuarioTarjeta.text = metodoPago.nombreUsuarioTarjeta;
      _txtFechaExpiracion.text = metodoPago.fechaExpiracion;
      _txtCVV.text = metodoPago.cvv;
    });

    super.initState();
  }

  @override
  void dispose() {
    _txtNumeroTarjeta.dispose();
    _txtNombreUsuarioTarjeta.dispose();
    _txtFechaExpiracion.dispose();
    _txtCVV.dispose();

    _fnCNumeroTarjeta.dispose();
    _fnNombreUsuarioTarjeta.dispose();
    _fnFechaExpiracion.dispose();
    _fnCVV.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Metodo Pago'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Form
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ingreso de numero de tarjeta
                    TextFormField(
                      controller: _txtNumeroTarjeta,
                      focusNode: _fnCNumeroTarjeta,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FormatoNumeroTarjeta(),
                        LengthLimitingTextInputFormatter(19),
                      ],
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnNombreUsuarioTarjeta),
                      decoration: const InputDecoration(
                        hintText: 'Ingresa tu numero de tarjeta',
                        labelText: 'Numero de tarjeta',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso del nombre del dueño de la tarjeta
                    TextFormField(
                      controller: _txtNombreUsuarioTarjeta,
                      focusNode: _fnNombreUsuarioTarjeta,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnFechaExpiracion),
                      decoration: const InputDecoration(
                        hintText: 'Ingrese el Nombre del Dueño de la Tarjeta',
                        labelText: 'Nombre del Dueño de la tarjeta',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso fecha de expiracion
                    TextFormField(
                      controller: _txtFechaExpiracion,
                      focusNode: _fnFechaExpiracion,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FormatoExpiracionTarjeta(),
                        LengthLimitingTextInputFormatter(7),
                      ],
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnCVV),
                      decoration: const InputDecoration(
                        hintText: 'MM/YY',
                        labelText: 'Fecha de Expiracion',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso del CVV
                    TextFormField(
                      controller: _txtCVV,
                      focusNode: _fnCVV,
                      validator: validacion.validacionCvv,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onFieldSubmitted: (valor) => FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                        hintText: 'Ingresa el CVV de la Tarjeta',
                        labelText: 'CVV',
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Boton para añadir el producto
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Consumer<ProveedorMetodoPago>(
              builder: (context, valor, child) {
                if (_isCargando) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ElevatedButton(
                  child: const Text('Editar Metodo Pago'),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate() && !_isCargando) {
                      try {
                        setState(() {
                          _isCargando = true;
                        });

                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                        MetodoPago data = MetodoPago(
                          metodoPagoId: metodoPago.metodoPagoId,
                          numeroTarjeta: _txtNumeroTarjeta.text,
                          nombreUsuarioTarjeta: _txtNombreUsuarioTarjeta.text,
                          fechaExpiracion: _txtFechaExpiracion.text,
                          cvv: _txtCVV.text,
                          createdAt: metodoPago.createdAt,
                          updatedAt: DateTime.now(),
                        );

                        String cuentaId = FirebaseAuth.instance.currentUser!.uid;

                        await valor.update(cuentaId: cuentaId, data: data).whenComplete(() {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Metodo de pago editado satisfactoriamente'),
                            ),
                          );
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          bannerError(context: context, msg: e.toString()),
                        );
                        setState(() {
                          _isCargando = false;
                        });
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

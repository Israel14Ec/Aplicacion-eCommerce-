import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/proveedores/proveedor_direccion.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PaginaAddDireccion extends StatefulWidget {
  const PaginaAddDireccion({Key? key}) : super(key: key);

  @override
  State<PaginaAddDireccion> createState() => _PaginaAddDireccionState();
}

class _PaginaAddDireccionState extends State<PaginaAddDireccion> {
  // Form Key (Para validacion)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador de TextEditing
  final TextEditingController _txtNombre = TextEditingController();
  final TextEditingController _txtDireccion = TextEditingController();
  final TextEditingController _txtCiudad = TextEditingController();
  final TextEditingController _txtCodigoCasa = TextEditingController();

  // FocusNode
  final FocusNode _fnNombre = FocusNode();
  final FocusNode _fnDireccion = FocusNode();
  final FocusNode _fnCiudad = FocusNode();
  final FocusNode _fnCodigoCasa = FocusNode();

  // Validacion
  TipoValidaciones validacion = TipoValidaciones.instancia;

  bool _isCargando = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _txtNombre.dispose();
    _txtDireccion.dispose();
    _txtCiudad.dispose();
    _txtCodigoCasa.dispose();

    _fnNombre.dispose();
    _fnDireccion.dispose();
    _fnCiudad.dispose();
    _fnCodigoCasa.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Direccion'),
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
                    // Ingreso del nombre de la direccion
                    TextFormField(
                      controller: _txtNombre,
                      focusNode: _fnNombre,
                      textCapitalization: TextCapitalization.words,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnDireccion),
                      decoration: const InputDecoration(
                        hintText: 'Ingresa el nombre de la direccion (ejemplo: Casa)',
                        labelText: 'Nombre',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso de las calles de la direccion
                    TextFormField(
                      controller: _txtDireccion,
                      focusNode: _fnDireccion,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                      minLines: 2,
                      maxLines: 10,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnCiudad),
                      decoration: const InputDecoration(
                        hintText: 'Ingresa las calles de la direccion',
                        labelText: 'Direccion',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso de la ciudad de la direccion
                    TextFormField(
                      controller: _txtCiudad,
                      focusNode: _fnCiudad,
                      validator: validacion.validacionVacio,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnCodigoCasa),
                      decoration: const InputDecoration(
                        hintText: 'Ingreso del nombre de la ciudad',
                        labelText: 'Ciudad',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso del codigo de la casa
                    TextFormField(
                      controller: _txtCodigoCasa,
                      focusNode: _fnCodigoCasa,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onFieldSubmitted: (valor) => FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                        hintText: 'Ingreso del codigo de la casa (Si no tiene codigo escriba 0000)',
                        labelText: 'Codigo Casa',
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Add Product Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Consumer<ProveedorDireccion>(
              builder: (context, valor, child) {
                if (_isCargando) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ElevatedButton(
                  child: const Text('Añadir Direccion'),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate() && !_isCargando) {
                      try {
                        setState(() {
                          _isCargando = true;
                        });

                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                        Direccion data = Direccion(
                          direccionId: ''.generateUID(),
                          nombre: _txtNombre.text,
                          direccion: _txtDireccion.text,
                          ciudad: _txtCiudad.text,
                          codigoCasa: _txtCodigoCasa.text,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );

                        String cuentaId = FirebaseAuth.instance.currentUser!.uid;

                        await valor.add(cuentaId: cuentaId, data: data).whenComplete(() {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Se ha añadido la direccion satisfactoriamente'),
                            ),
                          );
                          valor.getAddress(cuentaId: cuentaId);
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

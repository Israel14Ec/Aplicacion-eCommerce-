import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/proveedores/proveedor_direccion.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/core/dominio/entidades/direccion/direccion.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PaginaEditDireccion extends StatefulWidget {
  const PaginaEditDireccion({Key? key}) : super(key: key);

  @override
  State<PaginaEditDireccion> createState() => _PaginaEditDireccionState();
}

class _PaginaEditDireccionState extends State<PaginaEditDireccion> {
  late Direccion direccion;

  // Form Key (Para validaciones)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador del TextEditing
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
    Future.microtask(() {
      direccion = ModalRoute.of(context)!.settings.arguments as Direccion;

      _txtNombre.text = direccion.nombre;
      _txtDireccion.text = direccion.direccion;
      _txtCiudad.text = direccion.ciudad;
      _txtCodigoCasa.text = direccion.codigoCasa;
    });
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
        title: const Text('Editar Direccion'),
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
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnDireccion),
                      decoration: const InputDecoration(
                        hintText: 'Ingresa el nombre de la direccion (Ejemplo: Casa)',
                        labelText: 'Nombre',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ingreso calles de la direccion
                    TextFormField(
                      controller: _txtDireccion,
                      focusNode: _fnDireccion,
                      validator: validacion.validacionVacio,
                      keyboardType: TextInputType.streetAddress,
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
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnCodigoCasa),
                      decoration: const InputDecoration(
                        hintText: 'Ingreso de la ciudad de la direccion',
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
                  child: const Text('Editar Direccion'),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate() && !_isCargando) {
                      try {
                        setState(() {
                          _isCargando = true;
                        });

                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                        Direccion data = Direccion(
                          direccionId: direccion.direccionId,
                          nombre: _txtNombre.text,
                          direccion: _txtDireccion.text,
                          ciudad: _txtCiudad.text,
                          codigoCasa: _txtCodigoCasa.text,
                          createdAt: direccion.createdAt,
                          updatedAt: DateTime.now(),
                        );

                        String cuentaId = FirebaseAuth.instance.currentUser!.uid;

                        await valor.update(cuentaId: cuentaId, data: data).whenComplete(() {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Direccion actualizada satisfactoriamente'),
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

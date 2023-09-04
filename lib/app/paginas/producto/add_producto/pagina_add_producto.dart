import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/proveedores/proveedor_producto.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:edreams/verificaciones/formato_texto_numerico.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import '../../../widgets/get_imagenes.dart';
import '../../../widgets/get_img_paths.dart';



class PaginaAddProducto extends StatefulWidget {
  const PaginaAddProducto({Key? key}) : super(key: key);

  @override
  State<PaginaAddProducto> createState() => _PaginaAddProductoState();
}

class _PaginaAddProductoState extends State<PaginaAddProducto> {

  //imagenes
  List<html.File> selectedImages = [];
  List<String> imageUrls = [];
  // Form Key (Para validar)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador del TextEditing
  final TextEditingController _txtNombreProducto = TextEditingController();
  final TextEditingController _txtPrecio = TextEditingController();
  final TextEditingController _txtDescripcion = TextEditingController();
  final TextEditingController _txtStock = TextEditingController();

  // FocusNode
  final FocusNode _fnNombreProducto = FocusNode();
  final FocusNode _fnPrecio = FocusNode();
  final FocusNode _fnDescripcion = FocusNode();
  final FocusNode _fnStock = FocusNode();

  // Validacion
  TipoValidaciones validation = TipoValidaciones.instancia;

  @override
  void dispose() {
    _txtNombreProducto.dispose();
    _txtPrecio.dispose();
    _txtDescripcion.dispose();
    _txtStock.dispose();

    _fnNombreProducto.dispose();
    _fnPrecio.dispose();
    _fnDescripcion.dispose();
    _fnStock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Producto'),
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
                    // Insertar nombre del producto
                    TextFormField(
                      controller: _txtNombreProducto,
                      focusNode: _fnNombreProducto,
                      validator: validation.validacionVacio,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnPrecio),
                      decoration: const InputDecoration(
                        hintText: 'Ingresar nombre del producto',
                        labelText: 'Nombre del Producto',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Insertar precio
                    TextFormField(
                      controller: _txtPrecio,
                      focusNode: _fnPrecio,
                      validator: validation.validacionVacio,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnDescripcion),
                      decoration: const InputDecoration(
                        hintText: 'Ingresar el precio del producto',
                        labelText: 'Precio del Producto',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Insertar descripcion
                    TextFormField(
                      controller: _txtDescripcion,
                      focusNode: _fnDescripcion,
                      validator: validation.validacionVacio,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 10,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnStock),
                      decoration: const InputDecoration(
                        hintText: 'Ingresar la descripcion del producto',
                        labelText: 'Descripcion',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Insertar el stock
                    TextFormField(
                      controller: _txtStock,
                      focusNode: _fnStock,
                      validator: validation.validacionVacio,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FormatoTextoNumerico(),
                      ],
                      onFieldSubmitted: (valor) => FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                        hintText: 'Insertar el stock del producto',
                        labelText: 'Stock',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Producto imagenes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Imagen del producto'),
                        TextButton(
                          onPressed: () async {
                           final List<html.File> images = await getImagenes((selectedImages) {
                                    setState(() {
                                      this.selectedImages = selectedImages;
                                    });
                                  });
                                    // Actualizar las URL de las imágenes seleccionadas
                                    final newImageUrls = <String>[];
                                    for (final image in images) {
                                      final imageUrl = html.Url.createObjectUrl(image);
                                      newImageUrls.add(imageUrl);
                                    }

                                    setState(() {
                                      imageUrls = newImageUrls;
                            });
                          },
                          child: const Text('Añadir Imagen'),
                        ),
                      ],
                    ),
                    
                    Container(
                                  height: 350,
                                  color: Colors.white70,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      final imageUrl = imageUrls[index];
                                      return Dismissible(
                                        key: Key(imageUrl),
                                        direction: DismissDirection.up,
                                        onDismissed: (direction) {
                                          setState(() {
                                            imageUrls.removeAt(index);
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Image.network(
                                                imageUrl,
                                                height: 340,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    imageUrls.removeAt(index);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.pink,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
            child: Consumer<ProveedorProducto>(
              builder: (context, value, child) {
                if (value.isCargando) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ElevatedButton(
                  child: const Text('Añadir Producto'),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                       if (selectedImages.isEmpty || selectedImages.length >= 5)  {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Se debe añadir de 1 a 5 imagenes'),
                        ),
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate() && !value.isCargando) {
                      try {
                        value.setCargando = true;

                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                        
                        List<String> productoImagen = [];


                          for (var element in selectedImages) {
                          Reference ref = FirebaseStorage.instance.ref().child('Productos/${element.name}');

                          // Guarda la imagen en el storage
                          final dataImage = await ref.putBlob(element);

                          // Obtiene el url de la imagen del storage
                          String imagenUrl = await dataImage.ref.getDownloadURL();
                          productoImagen.add(imagenUrl);
                        }
                       List<String> imagePaths = await getImagePaths(selectedImages);

                        Producto data = Producto(
                          productoId: ''.generateUID(),
                          productoNombre: _txtNombreProducto.text,
                          productoPrecio: NumberFormat().parse(_txtPrecio.text).toDouble(),
                          productoDescripcion: _txtDescripcion.text,
                          productoImagen: imagePaths,
                          reviewsTotal: 0,
                          rating: 0,
                          isDeleted: false,
                          stock: int.parse(_txtStock.text),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          
                        );

                        await value.add(data: data).whenComplete(() {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Producto añadido exitosamente'),
                            ),
                          );
                          value.cargarListaProducto();
                        });
                      } catch (e) {
                        print(e.toString());
                        value.setCargando = false;
                        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          bannerError(context: context, msg: e.toString()),
                        );
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







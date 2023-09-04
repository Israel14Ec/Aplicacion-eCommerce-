import 'dart:io';
import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/proveedores/proveedor_producto.dart';
import 'package:edreams/app/widgets/banner_error.dart';
import 'package:edreams/core/dominio/entidades/producto/producto.dart';
import 'package:edreams/verificaciones/comprimir_imagen.dart';
import 'package:edreams/verificaciones/formato_texto_numerico.dart';
import '../../../widgets/get_imagenes.dart';
import '../../../widgets/get_img_paths.dart';
import 'widgets/preview_imagen_producto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class PaginaEditProducto extends StatefulWidget {
  const PaginaEditProducto({Key? key}) : super(key: key);

  @override
  State<PaginaEditProducto> createState() => _PaginaEditProductoState();
}

class _PaginaEditProductoState extends State<PaginaEditProducto> {

  // Producto a editar
  late Producto dataProduct;

  // Form Key (Para validaciones)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controlador TextEditing
  final TextEditingController _txtNombreProducto = TextEditingController();
  final TextEditingController _txtPrecio = TextEditingController();
  final TextEditingController _txtDescripcion = TextEditingController();
  final TextEditingController _txtStock = TextEditingController();

  // FocusNode
  final FocusNode _fnNombreProducto = FocusNode();
  final FocusNode _fnPrecio = FocusNode();
  final FocusNode _fnDescripcion = FocusNode();
  final FocusNode _fnStock = FocusNode();

  // Imagenes
  
  final List<XFile> _productoImages = [];
      //imagenes
  List<html.File> selectedImages = [];
  List<String> imageUrls = [];
  

  // Validacion
  TipoValidaciones validation = TipoValidaciones.instancia;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        dataProduct = ModalRoute.of(context)!.settings.arguments as Producto;

        _txtNombreProducto.text = dataProduct.productoNombre;
        _txtPrecio.text = '${dataProduct.productoPrecio}';
        _txtDescripcion.text = dataProduct.productoDescripcion;
        _txtStock.text = NumberFormat('#,###').format(dataProduct.stock);
      });
    });
    super.initState();
  }

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
        title: const Text('Editar Producto'),
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
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnPrecio),
                      decoration: const InputDecoration(
                        hintText: 'Ingresar el nombre del producto',
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
                        labelText: 'Precio Producto',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Insertar descripcion
                    TextFormField(
                      controller: _txtDescripcion,
                      focusNode: _fnDescripcion,
                      validator: validation.validacionVacio,
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 10,
                      onFieldSubmitted: (valor) => FocusScope.of(context).requestFocus(_fnStock),
                      decoration: const InputDecoration(
                        hintText: 'Insertar descripcion del producto',
                        labelText: 'Descripcion',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Insertar stock del producto
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
                        hintText: 'Ingresar el stock del producto',
                        labelText: 'Stock',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Imagenes del producto
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
                    _productoImages.isEmpty && (dataProduct.productoImagen.isEmpty)
                        ? Text(
                            'Maximo 5 imagenes',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : Wrap(
                            children: [
                              ...dataProduct.productoImagen.map(
                                (e) => ImageProductPreview(
                                  image: Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    loadingBuilder: (_, child, progresoCarga) {
                                      if (progresoCarga == null) return child;

                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: progresoCarga.expectedTotalBytes != null
                                              ? progresoCarga.cumulativeBytesLoaded /
                                                  progresoCarga.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                  onTap: () {
                                    setState(() {
                                      dataProduct.productoImagen.remove(e);
                                    });
                                  },
                                ),
                              ),
                              ..._productoImages.map((e) {
                                return ImageProductPreview(
                                  image: Image.file(
                                    File(e.path),
                                    fit: BoxFit.cover,
                                    width: 64,
                                    height: 64,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _productoImages.remove(e);
                                    });
                                  },
                                );
                              })
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

          // Boton de añadir producto
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
  child: const Text('Editar Producto'),
  onPressed: () async {
    FocusScope.of(context).unfocus();

    if (selectedImages.isEmpty && dataProduct.productoImagen.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes añadir al menos una imagen'),
        ),
      );
      return;
    }

    if (selectedImages.length + dataProduct.productoImagen.length > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Máximo 5 imágenes permitidas'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate() && !value.isCargando) {
      try {
        value.setCargando = true;

        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

            List<String> productoImagen = List<String>.from(dataProduct.productoImagen);
            List<String> imagePaths = await getImagePaths(selectedImages);
            List<String> allImagePaths = [...imagePaths, ...productoImagen];
            productoImagen = allImagePaths.toList();

            Producto data = Producto(
              productoId: dataProduct.productoId,
              productoNombre: _txtNombreProducto.text,
              productoPrecio: NumberFormat().parse(_txtPrecio.text).toDouble(),
              productoDescripcion: _txtDescripcion.text,
              productoImagen: productoImagen,
              reviewsTotal: dataProduct.reviewsTotal,
              rating: dataProduct.rating,
              isDeleted: false,
              stock: int.parse(_txtStock.text),
              createdAt: dataProduct.createdAt,
              updatedAt: DateTime.now(),
            );

        await value.update(data: data).whenComplete(() {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Producto Editado Exitosamente'),
            ),
          );
          value.cargarDetallesProducto(productoId: data.productoId);
          value.cargarListaProducto();
        });
      } catch (e) {
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

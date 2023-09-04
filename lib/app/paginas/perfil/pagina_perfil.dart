import 'package:edreams/app/constantes/tipo_validaciones.dart';
import 'package:edreams/app/constantes/valor_colores.dart';
import 'package:edreams/app/paginas/perfil/widgets/action_row.dart';
import 'package:edreams/app/paginas/perfil/widgets/dialogo_edit_perfil.dart';
import 'package:edreams/app/paginas/perfil/widgets/tile_info_personal.dart';
import 'package:edreams/app/proveedores/proveedor_auten.dart';
import 'package:edreams/app/proveedores/proveedor_cuenta.dart';
import 'package:edreams/app/proveedores/proveedor_modo_oscuro.dart';
import 'package:edreams/app/widgets/get_img_paths.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/rutas.dart';
import 'package:edreams/verificaciones/extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'package:provider/provider.dart';
import '../../widgets/banner_error.dart';
import '../../widgets/get_imagenes.dart';


class PaginaPerfil extends StatefulWidget {
  const PaginaPerfil({Key? key}) : super(key: key);

  @override
  State<PaginaPerfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<PaginaPerfil> {
  // Selector de imágenes
  List<html.File> selectedImages = [];
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProveedorCuenta>(
        builder: (context, valor, child) {
          if (valor.isPerfilCargado) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Obtenemos la cuenta actual desde el proveedor
   

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),

              Center(
  // Muestra la foto de perfil
  child: ClipOval(
    child: Container(
      height: 100,
      width: 100,
      color: Colors.white,
      child: Stack(
        children: [
          
          if (valor.cuenta.urlFotoPerfil != null && valor.cuenta.urlFotoPerfil.isNotEmpty)
         
            // Mostrar la imagen de perfil si existe una URL válida en valor.cuenta.urlFotoPerfil
            Image.network(
              valor.cuenta.urlFotoPerfil,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          if (imageUrls.isNotEmpty) // Mostrar la imagen seleccionada (antes de guardarla)
            Image.network(
              imageUrls.first,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          if (valor.cuenta.urlFotoPerfil == null || valor.cuenta.urlFotoPerfil.isEmpty)
            // Mostrar el icono si no hay imagen de perfil guardada y no hay imagen seleccionada
            const Center(
              child: Icon(
                Icons.person_pin,
                color: Colors.pink,
                size: 100,
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  imageUrls.clear(); // Eliminar todas las imágenes seleccionadas (antes de guardarlas)
                });
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),


                  const SizedBox(height: 10),

                  // Botón para obtener la imagen
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final List<html.File> images = await getImagenes((selectedImages) {
                          setState(() {
                            this.selectedImages = selectedImages;
                          });
                        });

                        // Comprueba si se seleccionó una imagen y llama a la función para guardarla en Firestore
                        if (images.isNotEmpty) {
                          List<String> imagePaths = await getImagePaths(selectedImages);
                          String img = imagePaths.isNotEmpty ? imagePaths[0] : ''; // Obtiene el valor de la posición 0
                          context.read<ProveedorCuenta>().guardarFotoPerfil(img);
                        }

                        // Actualiza las URL de las imágenes seleccionadas
                        final newImageUrls = <String>[];
                        for (final image in images) {
                          final imageUrl = html.Url.createObjectUrl(image);
                          newImageUrls.add(imageUrl);
                        }

                        setState(() {
                          imageUrls = newImageUrls;
                        });
                      },
                      child: const Text('Añadir foto de perfil'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Información personal
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Informacion Personal",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Name
                  TileInfoPersonal(
                    infoPersonal: 'Nombre',
                    valor: valor.cuenta.nombre,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DialogoEditPerfil(
                          titulo: 'Edita tu nombre',
                          textoSugerido: 'Ingresa tu nombre',
                          labelTexto: 'Nombre',
                          valorInicial: valor.cuenta.nombre,
                          nombreCampo: 'nombre_completo',
                          validacion: TipoValidaciones.instancia.validacionVacio,
                        ),
                      );
                    },
                  ),
                  // Direccion email
                  TileInfoPersonal(
                    infoPersonal: 'Email',
                    valor: valor.cuenta.email,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DialogoEditPerfil(
                          titulo: 'Edita tu dirección de correo electrónico',
                          textoSugerido: 'Ingresa tu dirección de correo electrónico',
                          labelTexto: 'Dirección de correo electrónico',
                          valorInicial: valor.cuenta.email,
                          nombreCampo: 'direccion_email',
                          validacion: TipoValidaciones.instancia.validacionEmail,
                        ),
                      );
                    },
                  ),
                  // Numero telefono
                  TileInfoPersonal(
                    infoPersonal: 'Phone',
                    valor: valor.cuenta.numeroTelefonico.separarCodigoPais(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DialogoEditPerfil(
                          titulo: 'Edita tu número telefónico',
                          textoSugerido: 'Ingreso tu número telefónico',
                          labelTexto: 'Número Telefónico',
                          valorInicial: valor.cuenta.numeroTelefonico,
                          nombreCampo: 'numero_telefonico',
                          validacion: TipoValidaciones.instancia.validacionVacio,
                          isTelefono: true,
                        ),
                      );
                    },
                  ),

                  // Accion
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Accion",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Resetear Password
                  ActionRow(
                    label: 'Resetear Contraseña',
                    onTap: () {
                      resetPassword(emailAddress: valor.cuenta.email);
                    },
                  ),
                  const Divider(height: 1),

                  // Manejo de direccion
                  if (flavor.flavor == Flavor.usuario)
                    ActionRow(
                      label: 'Manejo Direccion',
                      onTap: () {
                        RutaNavegacion.toManejoDireccion(context: context);
                      },
                    ),
                  if (flavor.flavor == Flavor.usuario) const Divider(height: 1),

                  // Manage Payment Method
                  if (flavor.flavor == Flavor.usuario)
                    ActionRow(
                      label: 'Manejo de Metodo de Pago',
                      onTap: () {
                        RutaNavegacion.toManejoMetodoPago(context: context);
                      },
                    ),
                  if (flavor.flavor == Flavor.usuario) const Divider(height: 1),

                  // Switch al modo N
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text('Modo Oscuro'),
                        ),
                        Consumer<ProveedorModoOscuro>(
                          builder: (context, modoOscuro, child) {
                            return Switch(
                              value: modoOscuro.isModoOscuro,
                              onChanged: (valor) {
                                modoOscuro.setDarkMode(valor);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Acerca de
                  ActionRow(
                    label: 'Acerca de',
                    onTap: () {
                      showAboutDialog(context: context);
                    },
                  ),
                  const Divider(height: 1),

                  // Logout
                  ActionRow(
                    label: 'Cerrar sesion',
                    onTap: () {
                      context.read<ProveedorAuten>().logout();
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  resetPassword({required String emailAddress}) async {
    try {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

      await context
          .read<ProveedorAuten>()
          .resetPassword(
            email: emailAddress,
          )
          .whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email para resetear la contraseña enviado'),
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
}
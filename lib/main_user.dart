import 'package:edreams/app/app.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:edreams/configuracion/usuario_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

//import 'dart:html' as html;

// flutter run --flavor user -t .\lib\main_user.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  FlavorConfig(
    flavor: Flavor.usuario,
    flavorValores: FlavorValues(
      rolConfig: UsuarioConfig(),
    ),
  );
  //html.window.localStorage['loadLandbot'] = 'true';
  runApp(
    
    const App(),
  );
}

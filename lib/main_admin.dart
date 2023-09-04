import 'package:edreams/app/app.dart';
import 'package:edreams/configuracion/admin_config.dart';
import 'package:edreams/configuracion/flavor_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// flutter run --flavor admin -t .\lib\main_admin.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlavorConfig(
    flavor: Flavor.admin,
    flavorValores: FlavorValues(
      rolConfig: AdminConfig(),
    ),
  );

  runApp(
    const App(),
  );
}

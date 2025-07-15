import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:tokyo/app.dart';
import 'package:tokyo/firebase_option.dart';
import 'package:tokyo/providers.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR', null);
  setupDependencies();
  if (kIsWeb) {
    await Firebase.initializeApp(options: firebaseOptionsFlutter);
  } else {
    await Firebase.initializeApp();
  }
  runApp(App());
}

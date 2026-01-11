import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishna/firebase_options.dart';
import 'package:krishna/krishna_portfolio_app.dart';
import 'package:krishna/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Google Fonts for web to prevent font rendering issues
  if (kIsWeb) {
    GoogleFonts.config.allowRuntimeFetching = true;
  }

  //initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initApp();

  runApp(const KrishnaPortfolioApp());
}

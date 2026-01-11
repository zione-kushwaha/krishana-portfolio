import 'package:flutter/material.dart';
import 'package:krishna/config/theme/themes.dart';
import 'package:krishna/provider/current_tag_notifier.dart';
import 'package:krishna/provider/message_sender_notifier.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/service_locator.dart';
import 'package:krishna/ui/home.dart';
import 'package:provider/provider.dart';

class KrishnaPortfolioApp extends StatelessWidget {
  const KrishnaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageSenderNotifier(locator())),
        ChangeNotifierProvider(create: (_) => CurrentTagNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Krishana | Founder & CEO - Infinity Academy',
        theme: createLightTheme(),
        home: const HomeScreen(),
        builder: (context, child) {
          return Screen(mediaQueryData: MediaQuery.of(context), child: child!);
        },
      ),
    );
  }
}

import 'package:bonfire/bonfire.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ishiki/narrator/narrator_controller.dart';
import 'package:ishiki/npc/npc_controller.dart';
import 'package:ishiki/player/player_controller.dart';
import 'package:ishiki/screens/menu.dart';
import 'package:ishiki/utils/audio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'game.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GameAudio.initialize();
  BonfireInjector().put((i) => PlayerController());
  BonfireInjector().put((i) => NpcController());
  BonfireInjector().put((i) => NarratorController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        return Consumer<LocaleProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(fontFamily: '1bit'),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: provider.locale,
              supportedLocales: L10n.support,
              home: Scaffold(
                body: Material(
                  child: FlameSplashScreen(
                    theme: FlameSplashTheme.dark,
                    controller: FlameSplashController(
                      waitDuration: const Duration(seconds: 1),
                      fadeOutDuration: const Duration(seconds: 3),
                    ),
                    onFinish: (context) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

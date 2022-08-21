import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_web_buttons/flutter_web_buttons.dart';
import 'package:ishiki/screens/intro.dart';
import 'package:ishiki/utils/audio.dart';
import 'package:ishiki/utils/page_transition.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../utils/app_text_styles.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameAudio.menu();

    return Material(
      color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          return SizedBox.expand(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //* Buttons */
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(2.0),
                      child: FlutterWebButton.backgroundFill(
                        context.loc.play,
                        backgroundAnimatedColor: Colors.black,
                        onPressed: () {
                          GameAudio.stopBgm();
                          Navigator.push(
                            context,
                            CustomPageRoute(const IntroScreen()),
                          );
                        },
                        animationDuration: const Duration(milliseconds: 500),
                        flutterWebButtonOptions: AppTextStyles.button(
                          width: width * 0.25,
                          height: height * 0.065,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(2.0),
                      child: FlutterWebButton.backgroundFill(
                        context.loc.about,
                        backgroundAnimatedColor: Colors.black,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white),
                                ),
                                backgroundColor: Colors.black,
                                title: Text(
                                  context.loc.about,
                                  style: AppTextStyles.common,
                                ),
                                content: SingleChildScrollView(
                                  child: Text(
                                    "\n\n${context.loc.about_text}",
                                    style: AppTextStyles.common,
                                  ),
                                ),
                                actions: [
                                  SizedBox(
                                    width: width * 0.05,
                                    height: height * 0.075,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          context.loc.ok,
                                          style: AppTextStyles.common,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        animationDuration: const Duration(milliseconds: 500),
                        flutterWebButtonOptions: AppTextStyles.button(
                          width: width * 0.25,
                          height: height * 0.065,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(2.0),
                      child: FlutterWebButton.backgroundFill(
                        context.read<LocaleProvider>().locale ==
                                const Locale('en')
                            ? context.loc.english
                            : context.loc.portuguese,
                        backgroundAnimatedColor: Colors.black,
                        onPressed: () {
                          context.read<LocaleProvider>().setLocale(
                              context.read<LocaleProvider>().locale ==
                                      const Locale('en')
                                  ? const Locale('pt')
                                  : const Locale('en'));
                        },
                        animationDuration: const Duration(milliseconds: 500),
                        flutterWebButtonOptions: AppTextStyles.button(
                          width: width * 0.25,
                          height: height * 0.065,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //* Title / Controls */
                    ZoomIn(
                      preferences: const AnimationPreferences(
                        duration: Duration(seconds: 3),
                      ),
                      child: Text(context.loc.title,
                          style: AppTextStyles.mainTitle),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('0', style: AppTextStyles.common),
                        ),
                        ZoomIn(
                          preferences: const AnimationPreferences(
                            duration: Duration(seconds: 3),
                          ),
                          child: Pulse(
                            preferences: const AnimationPreferences(
                              duration: Duration(seconds: 4),
                              autoPlay: AnimationPlayStates.Loop,
                            ),
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.all(2.0),
                              child: FlutterWebButton.backgroundFill(
                                context.loc.ksp,
                                backgroundAnimatedColor: Colors.black,
                                onPressed: () {},
                                animationDuration:
                                    const Duration(milliseconds: 1500),
                                flutterWebButtonOptions: AppTextStyles.ksp(
                                  width: width * 0.30,
                                  height: height * 0.08,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('1', style: AppTextStyles.common),
                        ),
                      ],
                    ),

                    Text(context.loc.how_to_play, style: AppTextStyles.common),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ishiki/game.dart';
import 'package:ishiki/l10n/l10n.dart';
import 'package:ishiki/utils/page_transition.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Center(
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            onFinished: () {
              Future.delayed(const Duration(seconds: 1)).then((_) {
                Navigator.push(
                  context,
                  CustomPageRoute(const IshikiGame()),
                );
              });
            },
            animatedTexts: [
              FadeAnimatedText(
                context.loc.disclaimer,
                duration: const Duration(seconds: 8),
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: '1bit',
                  fontSize: MediaQuery.of(context).size.height / 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

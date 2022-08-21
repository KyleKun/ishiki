import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ishiki/l10n/l10n.dart';
import 'package:ishiki/screens/menu.dart';
import 'package:ishiki/utils/page_transition.dart';

class CreditsScreen extends StatefulWidget {
  const CreditsScreen({
    Key? key,
    required this.finalChoice,
  }) : super(key: key);
  final int finalChoice;

  @override
  CreditsScreenState createState() => CreditsScreenState();
}

class CreditsScreenState extends State<CreditsScreen> {
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
                  CustomPageRoute(const MainMenu()),
                );
              });
            },
            animatedTexts: [
              FadeAnimatedText(
                getEnding(widget.finalChoice),
                duration: const Duration(seconds: 7),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: '1bit',
                  fontSize: MediaQuery.of(context).size.height / 15,
                ),
              ),
              FadeAnimatedText(
                context.loc.credits,
                duration: const Duration(seconds: 7),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: '1bit',
                  fontSize: MediaQuery.of(context).size.height / 15,
                ),
              ),
              FadeAnimatedText(
                context.loc.thanks_for_playing,
                textAlign: TextAlign.center,
                duration: const Duration(seconds: 7),
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

  String getEnding(int finalChoice) {
    switch (finalChoice) {
      case 1:
        return context.loc.ending1;
      case 2:
        return context.loc.ending2;
      default:
        return context.loc.ending1;
    }
  }
}

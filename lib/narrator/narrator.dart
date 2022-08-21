import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ishiki/narrator/narrator_controller.dart';
import 'package:ishiki/l10n/l10n.dart';
import 'package:ishiki/npc/npc_controller.dart';

import '../player/player_controller.dart';
import '../utils/app_text_styles.dart';
import '../utils/audio.dart';

class Narrator extends StatefulWidget {
  const Narrator({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  State<Narrator> createState() => _NarratorState();
}

// Don't judge me, it was the first working way I found after long
// hours of working on this game, so I am not gonna change it >:)
class _NarratorState extends State<Narrator> {
  List<List<dynamic>>? allText;
  late PlayerController playerController;
  late NpcController npcController;
  late NarratorController narratorController;
  int currentIndex = 0;
  int tempIndex = 0;
  bool finished = false;
  Duration pause = const Duration(milliseconds: 200);

  @override
  void dispose() {
    playerController.dispose();
    npcController.dispose();
    narratorController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    allText ??= [
      ['', 1],
      [context.loc.c1l1, 4],
      [context.loc.c1l2, 4],
      [context.loc.c1l3, 5],
      [context.loc.c1l4, 5],
      [context.loc.c1l5, 5],
      [context.loc.c1l6, 4],
      [context.loc.c1l7, 4],
      [context.loc.c1l8, 5],
      [context.loc.c1l9, 3],
      [context.loc.c1l9b, 5],
      [context.loc.c1l10, 5],
      [context.loc.c1l11, 4],
      [context.loc.c1l11b, 3],
      [context.loc.c1l12, 5],
      [context.loc.c1l13, 5],
      [context.loc.c1l14, 5],
      [context.loc.c1l15, 5],
      [context.loc.c1l16, 4],
      [context.loc.c2l1, 4],
      [context.loc.c2l2, 4],
      [context.loc.c2l3, 4],
      [context.loc.c2l3b, 4],
      [context.loc.c2l4, 4],
      [context.loc.c2l5, 4],
      [context.loc.c2l6, 4],
      [context.loc.c2l7, 4],
      [context.loc.c2l7b, 4],
      [context.loc.c2l8, 4],
      [context.loc.c2l8b, 4],
      [context.loc.c2l8c, 3],
      [context.loc.c2l9, 4],
      [context.loc.c2l10, 4],
      [context.loc.c2l11, 4],
      [context.loc.c2l12, 4],
      [context.loc.c2l13, 4],
      [context.loc.c2l14, 4],
      [context.loc.c2l15, 4],
      [context.loc.c2l16, 4],
      [context.loc.c2l17, 4],
      [context.loc.c2l18, 4],
      [context.loc.c2l19, 4],
      [context.loc.c2l20, 4],
      [context.loc.c2l21, 3],
      [context.loc.c2l22, 4],
      [context.loc.c2l23, 4],
      [context.loc.c2l24, 4],
      [context.loc.c2l25, 4],
      [context.loc.c2l26, 4],
      [context.loc.c2l27, 4],
      [context.loc.c2l28, 4],
      [context.loc.c2l29, 4],
      [context.loc.c2l30, 4],
      [context.loc.c2l31, 5],
      [context.loc.c2l32, 4],
      [context.loc.c2l33, 4],
      [context.loc.c2l34, 4],
      [context.loc.c2l35, 4],
      [context.loc.c2l36, 4],
      [context.loc.c2l37, 3],
      [context.loc.c3l1, 4],
      [context.loc.c3l2, 4],
      [context.loc.c3l3, 4],
      [context.loc.c3l4, 4],
      [context.loc.c3l5, 4],
      [context.loc.c3l6, 4],
      [context.loc.c3l7, 4],
      [context.loc.c3l8, 4],
      [context.loc.c3l9, 4],
      [context.loc.c3l10, 4],
      [context.loc.c3l11, 4],
      [context.loc.c3l12, 4],
      [context.loc.c3l13, 3],
      [context.loc.c3l14, 4],
      [context.loc.c3l15, 4],
      [context.loc.c3l16, 4],
      [context.loc.c3l16b, 4],
      [context.loc.c3l16c, 3],
      [context.loc.c3l17, 4],
      [context.loc.c3l18, 4],
      [context.loc.c3l19, 4],
      [context.loc.c3l20, 4],
      [context.loc.c3l21, 3],
      [context.loc.c3l22, 4],
      [context.loc.c3l23, 4],
      [context.loc.c3l24, 4],
      [context.loc.c3l24b, 4],
      [context.loc.c3l25, 4],
      [context.loc.c3l26, 4],
      [context.loc.c3l27, 4],
      [context.loc.c3l28, 4],
      [context.loc.c3l29, 4],
      [context.loc.c3l30, 4],
      [context.loc.c3l31, 4],
      [context.loc.c3l31b, 5],
      [context.loc.c3l32, 5],
      [context.loc.c3l33, 5],
      [context.loc.c3l34, 5],
      [context.loc.c3l35, 5],
      [context.loc.c3l36, 5],
      [context.loc.c3l37, 5],
      [context.loc.c3l38, 5],
      [context.loc.c3l39, 5],
      [context.loc.c3l40, 5],
      [context.loc.c3l41, 5],
      [context.loc.c3l42, 5],
      [context.loc.c3l43, 5],
      [context.loc.c3l44, 5],
      [context.loc.c3l45, 5],
      [context.loc.c3l46, 5],
      [context.loc.c3l47, 5],
      [context.loc.c3l48, 5],
      [context.loc.c3l49, 4],
    ];
  }

  Future<void> loadText() async {
    playerController = BonfireInjector().get<PlayerController>();
    npcController = BonfireInjector().get<NpcController>();
    narratorController = BonfireInjector().get<NarratorController>();
  }

  void speak() {
    print('speaking again at ${tempIndex + 1}');
    setState(() {
      currentIndex = tempIndex + 1;
    });
  }

  void disappear() {
    print('displaying index ${currentIndex}');
    setState(() {
      tempIndex = currentIndex != 0 ? currentIndex : tempIndex;
      currentIndex = 0;
    });
    print('temp index ${tempIndex}');
  }

  void routine() {
    print('routine $currentIndex');
    setState(() {
      pause = const Duration(milliseconds: 200);
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadText(),
        builder: (context, snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });

          return AnimatedTextKit(
            isRepeatingAnimation: true,
            pause: pause,
            onNext: (int __, _) {
              ///* Triggers */
              if (currentIndex == 5) {
                playerController.visible = true;
              }
              if (currentIndex == 18) {
                npcController.visible = true;
                npcController.lockMove = false;
                playerController.startChapterTwo();
              }
              if (currentIndex == 37) {
                narratorController.setExplorationStarted();
                playerController.addTargets();
              }
              if (currentIndex == 45) {
                playerController.enableMerge = true;
              }
              if (currentIndex == 56) {
                playerController.unmerge = true;
              }

              if (currentIndex == 59) {
                narratorController.setExplorationStarted();
                playerController.addTargets();
              }

              if (currentIndex == 65) {
                playerController.enableSecondMerge = true;
              }

              if (currentIndex == 67) {
                playerController.unmergeSecond = true;
              }

              if (currentIndex == 73) {
                playerController.arguing = true;
              }

              if (currentIndex == 82) {
                playerController.killed = true;
              }

              ///* Updater */
              if (currentIndex < allText!.length) {
                // End
                print(currentIndex);
                if (currentIndex == allText!.length - 1) {
                  setState(() {
                    finished = true;
                  });
                  GameAudio.stopBgm();

                  /// Show overlay
                  playerController.gameRef.overlayManager.add('final_choice');
                  // playerController.reset();
                  // npcController.reset();
                  narratorController.reset();
                } else if (narratorController.explorationStarted) {
                  print('exploration enabled');
                  if (narratorController.explorationCompletedCount == 4) {
                    print('FINISHED EXPLORATION');
                    speak();
                    narratorController.setExplorationStarted(value: false);
                  } else {
                    disappear();
                  }
                } else if (playerController.enableMerge) {
                  print('merge enabled');
                  if (playerController.finishedMerge) {
                    print('FINISHED MERGE');
                    speak();
                    playerController.enableMerge = false;
                  } else {
                    disappear();
                  }
                } else if (playerController.enableSecondMerge) {
                  print('merge 2 enabled');
                  if (playerController.finishedSecondMerge) {
                    print('FINISHED 2 MERGE');
                    speak();
                    playerController.enableSecondMerge = false;
                  } else {
                    disappear();
                  }
                } else if (!finished) {
                  routine();
                }
              }
            },
            animatedTexts: [
              for (int i = 0; i < allText!.length; i++)
                FadeAnimatedText(
                  allText![currentIndex].first,
                  textStyle: AppTextStyles.dialogue(
                    height: widget.height,
                  ),
                  duration: Duration(seconds: allText![currentIndex].last),
                  textAlign: TextAlign.center,
                ),
            ],
          );
        });
  }
}

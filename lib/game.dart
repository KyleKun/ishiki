import 'package:bonfire/bonfire.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_buttons/flutter_web_buttons.dart';
import 'package:ishiki/l10n/l10n.dart';
import 'package:ishiki/player/player.dart';
import 'package:ishiki/screens/credits.dart';
import 'package:ishiki/utils/app_text_styles.dart';
import 'package:ishiki/narrator/narrator.dart';
import 'package:ishiki/utils/audio.dart';

import 'npc/npc.dart';
import 'utils/page_transition.dart';

class IshikiGame extends StatefulWidget {
  const IshikiGame({Key? key}) : super(key: key);

  @override
  State<IshikiGame> createState() => _IshikiGameState();
}

late FocusNode focusNode;

class _IshikiGameState extends State<IshikiGame> {
  @override
  void initState() {
    focusNode = FocusNode();
    Future.delayed(const Duration(milliseconds: 500), () {
      GameAudio.playTheme();
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileSize = constraints.maxWidth / 55;
        final firstChoice = context.loc.final1;
        final secondChoice = context.loc.final2;
        final thirdChoice = context.loc.final3;
        return Focus(
          focusNode: focusNode,
          autofocus: true,
          canRequestFocus: true,
          child: BonfireTiledWidget(
            progress: Material(
              color: Colors.black,
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    context.loc.loading,
                    style: AppTextStyles.mainTitle,
                  ),
                ),
              ),
            ),
            interface: GameInterface(),
            joystick: Joystick(
              keyboardConfig: KeyboardConfig(
                keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
                acceptedKeys: [
                  LogicalKeyboardKey.enter,
                  LogicalKeyboardKey.space,
                ],
              ),
              actions: [
                JoystickAction(
                  actionId: LogicalKeyboardKey.enter.keyId,
                  size: 0,
                ),
                JoystickAction(
                  actionId: LogicalKeyboardKey.space.keyId,
                  size: 0,
                ),
              ],
            ),
            cameraConfig: CameraConfig(
              moveOnlyMapArea: true,
              smoothCameraSpeed: 2.0,
              zoom: 1.0,
            ),
            player: IshikiPlayer(
              Vector2(constraints.maxWidth / 2, constraints.maxHeight / 2),
            ),
            background: BackgroundColorGame(Colors.black),
            // showCollisionArea: true,

            overlayBuilderMap: {
              'final_choice': (BuildContext context, BonfireGame game) {
                return Material(
                  color: Colors.transparent,
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(2.0),
                          child: FlutterWebButton.backgroundFill(
                            firstChoice,
                            backgroundAnimatedColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                CustomPageRoute(const CreditsScreen(
                                  finalChoice: 1,
                                )),
                              );
                            },
                            animationDuration:
                                const Duration(milliseconds: 500),
                            flutterWebButtonOptions: AppTextStyles.button(
                              width: constraints.maxWidth * 0.25,
                              height: constraints.maxHeight * 0.065,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(2.0),
                          child: FlutterWebButton.backgroundFill(
                            secondChoice,
                            backgroundAnimatedColor: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                CustomPageRoute(const CreditsScreen(
                                  finalChoice: 2,
                                )),
                              );
                            },
                            animationDuration:
                                const Duration(milliseconds: 500),
                            flutterWebButtonOptions: AppTextStyles.button(
                              width: constraints.maxWidth * 0.25,
                              height: constraints.maxHeight * 0.065,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(2.0),
                          child: FlutterWebButton.backgroundFill(
                            thirdChoice,
                            backgroundAnimatedColor: Colors.black,
                            onPressed: () {
                              // Why player gets locked? This was supposed to be the best part...
                              game.overlayManager.remove('final_choice');
                              game.overlayManager.remove('narrator');
                              game.resumeEngine();
                              focusNode.requestFocus();
                              game.resumeEngine();
                            },
                            animationDuration:
                                const Duration(milliseconds: 500),
                            flutterWebButtonOptions: AppTextStyles.button(
                              width: constraints.maxWidth * 0.25,
                              height: constraints.maxHeight * 0.065,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              'narrator': (BuildContext context, BonfireGame game) {
                return Padding(
                  padding: EdgeInsets.all(constraints.maxHeight / 10),
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Narrator(
                          height: constraints.maxHeight,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            initialActiveOverlays: const ['narrator'],
            map: TiledWorldMap(
              'tiled/map.json',
              forceTileSize: Size(tileSize, tileSize),
              objectsBuilder: {
                'npc': (properties) => IshikiNpc(properties.position),
              },
            ),
          ),
        );
      },
    );
  }
}
